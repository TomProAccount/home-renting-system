import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../generated/l10n.dart';

class UnauthorizedScreen extends StatelessWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).notAutorise),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: Text(S.of(context).goToLogin),
            ),
          ],
        ),
      ),
    );
  }
}
