import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/main_navigation.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        switch (authProvider.status) {
          case AuthStatus.initial:
          case AuthStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          
          case AuthStatus.authenticated:
            return const MainNavigation();
          
          case AuthStatus.unauthenticated:
          case AuthStatus.error:
            // If coming from sign out, go directly to login screen
            // Otherwise show landing screen for new users
            return const LoginScreen();
        }
      },
    );
  }
}
