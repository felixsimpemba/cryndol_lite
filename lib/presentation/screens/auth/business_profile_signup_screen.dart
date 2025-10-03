import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_overlay.dart';
import '../../widgets/common/main_navigation.dart';

class BusinessProfileSignupScreen extends StatefulWidget {
  const BusinessProfileSignupScreen({super.key});

  @override
  State<BusinessProfileSignupScreen> createState() => _BusinessProfileSignupScreenState();
}

class _BusinessProfileSignupScreenState extends State<BusinessProfileSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  bool _hasBusinessProfile = false;

  @override
  void dispose() {
    _businessNameController.dispose();
    super.dispose();
  }

  Future<void> _handleCompleteSignup() async {
    if (_hasBusinessProfile && (_formKey.currentState?.validate() ?? false)) {
      final authProvider = context.read<AuthProvider>();
      
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      
      try {
        final success = await authProvider.createBusinessProfile(
          businessName: _businessNameController.text.trim(),
        );
        
        // Hide loading dialog
        if (mounted) Navigator.of(context).pop();
        
        if (success && mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Business profile created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Navigate to main app
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            ),
            (route) => false,
          );
        } else if (mounted) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authProvider.errorMessage ?? 'Failed to create business profile'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Hide loading dialog
        if (mounted) Navigator.of(context).pop();
        
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else if (!_hasBusinessProfile) {
      // Skip business profile and go to main app
      final authProvider = context.read<AuthProvider>();
      
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      
      try {
        await authProvider.skipBusinessProfile();
        
        // Hide loading dialog
        if (mounted) Navigator.of(context).pop();
        
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            ),
            (route) => false,
          );
        }
      } catch (e) {
        // Hide loading dialog
        if (mounted) Navigator.of(context).pop();
        
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _hasBusinessProfile = false;
              });
              _handleCompleteSignup();
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return LoadingOverlay(
            isLoading: authProvider.isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Header
                    Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.business_outlined,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Business Profile',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your business information (optional)',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Business Profile Toggle
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _hasBusinessProfile,
                            onChanged: (value) {
                              setState(() {
                                _hasBusinessProfile = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'I have a business profile',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Add your business information to get started with business loan management',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    if (_hasBusinessProfile) ...[
                      const SizedBox(height: 24),
                      
                      // Business Form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _businessNameController,
                              labelText: 'Business Name',
                              hintText: 'Enter your business name',
                              prefixIcon: Icons.business_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your business name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 32),
                    
                    // Complete Setup Button
                    CustomButton(
                      text: _hasBusinessProfile ? 'Complete Setup' : 'Get Started',
                      onPressed: _handleCompleteSignup,
                      icon: Icons.check_circle_outline,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Step 2 of 2',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
