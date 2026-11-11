import 'package:flutter/material.dart';

/// Splash screen placeholder.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(stage 1): implement splash animation and session check
    return Scaffold(
      appBar: AppBar(title: const Text('Splash')),
      body: const Center(child: Text('Splash Page Placeholder')),
    );
  }
}
