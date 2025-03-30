import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dda_desktop/logger.dart';
import 'package:dda_desktop/models/auth.dart';

const _verifierCharacters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";
const _googleClientId =
    "910933693241-6j0i5i3bk66jhmc9r5m94puigm665v3d.apps.googleusercontent.com";
const _scopes = "openid email profile";
const _challengeMethod = "S256";
const _responseType = "code";
const _redirectUriPath = "/googleoauthredirect";
const _redirectUriPort = 65002;

String _getCodeVerifier() {
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(random.nextInt(85) + 43, (_) {
      return _verifierCharacters.codeUnitAt(
        random.nextInt(_verifierCharacters.length),
      );
    }),
  );
}

String _getCodeChallenge() {
  final verifierBytes = ascii.encode(_getCodeVerifier());
  final sha256Digest = sha256.convert(verifierBytes);
  return base64UrlEncode(sha256Digest.bytes).replaceAll('=', '');
}

Uri _getAuthorizationUrl() {
  return Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'client_id': _googleClientId,
    'redirect_uri':
        Uri.http("localhost:$_redirectUriPort", _redirectUriPath).toString(),
    'response_type': _responseType,
    'scope': _scopes,
    'code_challenge': _getCodeChallenge(),
    'code_challenge_method': _challengeMethod,
  });
}

Future<String?> _waitForAuthorizationCode() async {
  final codeCompleter = Completer<String?>();

  final internalRouter = Router();
  internalRouter.get(_redirectUriPath, (Request request) {
    final queryParams = request.requestedUri.queryParameters;
    if (queryParams["code"] != null) {
      codeCompleter.complete(queryParams["code"]);
      logger.i("Got successful response from Google authorization server.");
      return Response.ok("Thank you! You may close this page.");
    } else {
      logger.e(
        "Got response from Google authorization server, but it was empty.",
      );
      return Response.notFound(
        "Expected 'code' query param that was not present.",
      );
    }
  });

  logger.d("Starting authorization code response server...");
  final server = await serve(
    internalRouter.call,
    "localhost",
    _redirectUriPort,
  );
  logger.d("Authorization code response server started.");

  final authorizationCode = await codeCompleter.future.timeout(
    Duration(minutes: 5),
    onTimeout: () {
      logger.i("Authorization code reached timeout. Considering it failure.");
      return;
    },
  );

  logger.d("Closing response server...");
  await server.close();
  logger.d("Response server closed.");

  return authorizationCode;
}

Future<AuthToken> authorizeWithGoogle() async {
  logger.d("Launching authorization URL...");
  launchUrl(_getAuthorizationUrl());
  String? authorizationCode = await _waitForAuthorizationCode();

  logger.i("Authorization workflow done.");
  return AuthToken(
    "TESTTOKEN",
    User(
      DateTime.now(),
      "test@email.com",
      "Graham",
      "Austin",
      "Garbage",
      null,
      null,
    ),
  );
}
