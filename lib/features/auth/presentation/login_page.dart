import 'package:flutter/material.dart';

/// Login and registration placeholder page.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(stage 1): implement login and phone/email input form
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login Page Placeholder')),
    );
  }
}
