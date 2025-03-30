import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TMP, for testing. TODO: Remove.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        context.go("/login");
      });
    });

    return const Center(child: CircularProgressIndicator());
  }
}
