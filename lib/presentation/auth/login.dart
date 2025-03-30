import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:dda_desktop/models/auth.dart';
import 'package:dda_desktop/services/auth/google.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _doAuthorization() async {
    AuthToken? token = await authorizeWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [SignInButton(Buttons.Google, onPressed: _doAuthorization)],
      ),
    );
  }
}
