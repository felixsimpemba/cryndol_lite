import 'package:flutter/material.dart';
import '../../widgets/common/custom_button.dart';
import 'login_screen.dart';
import 'personal_profile_signup_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                           MediaQuery.of(context).padding.top - 
                           MediaQuery.of(context).padding.bottom - 48,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // App Logo and Branding
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 50,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // App Name
                    Text(
                      'Cryndol Lite',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Tagline
                    Text(
                      'Your Personal Loan Management Solution',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Features List
                    Column(
                      children: [
                        _buildFeatureItem(
                          context,
                          Icons.dashboard_outlined,
                          'Smart Dashboard',
                          'Track all your loans in one place',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          context,
                          Icons.payment_outlined,
                          'Payment Tracking',
                          'Never miss a payment again',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          context,
                          Icons.analytics_outlined,
                          'Financial Analytics',
                          'Understand your financial health',
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Action Buttons
                    Column(
                      children: [
                        CustomButton(
                          text: 'Get Started',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PersonalProfileSignupScreen(),
                              ),
                            );
                          },
                          icon: Icons.person_add_outlined,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          isSecondary: true,
                          icon: Icons.login_outlined,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Terms and Privacy
                        Text(
                          'By continuing, you agree to our Terms of Service and Privacy Policy',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
