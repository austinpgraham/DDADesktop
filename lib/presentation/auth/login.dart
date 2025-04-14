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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xfffeb06a),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(15),
            child: Text("Create & Collaborate", style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(height: 20),
          SignInButton(Buttons.Google, onPressed: _doAuthorization)
        ],
      ),
    );
  }
}
