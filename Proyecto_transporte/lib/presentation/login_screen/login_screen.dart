import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/app_logo_widget.dart';
import './widgets/biometric_prompt_widget.dart';
import './widgets/login_form_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _showBiometricPrompt = false;
  String _biometricType = 'fingerprint';

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@busticket.com': 'admin123',
    'usuario@test.com': 'usuario123',
    'conductor@bus.com': 'conductor123',
  };

  @override
  void initState() {
    super.initState();
    _detectBiometricType();
  }

  void _detectBiometricType() {
    // Simulate biometric type detection
    setState(() {
      _biometricType = 'fingerprint'; // Default to fingerprint
    });
  }

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      // Show biometric prompt for first-time login
      setState(() {
        _isLoading = false;
        _showBiometricPrompt = true;
      });
    } else {
      // Error handling
      setState(() {
        _isLoading = false;
      });

      String errorMessage =
          'Credenciales inválidas. Por favor verifica tu correo y contraseña.';

      if (!_mockCredentials.containsKey(email)) {
        errorMessage = 'Cuenta no encontrada. Verifica tu correo electrónico.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppTheme.errorRed,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(4.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _handleSocialLogin(String provider) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate social login
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Inicio de sesión con $provider próximamente'),
        backgroundColor: AppTheme.infoBlue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _handleBiometricSetup() {
    // Simulate biometric setup
    HapticFeedback.lightImpact();

    setState(() {
      _showBiometricPrompt = false;
    });

    // Navigate to home dashboard
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  void _skipBiometric() {
    setState(() {
      _showBiometricPrompt = false;
    });

    // Navigate to home dashboard
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  void _navigateToRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Funcionalidad de registro próximamente'),
        backgroundColor: AppTheme.infoBlue,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryNavy,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            GestureDetector(
              onTap: () {
                // Dismiss keyboard when tapping outside
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 6.h),

                        // App Logo
                        AppLogoWidget(),

                        SizedBox(height: 6.h),

                        // Login Form
                        LoginFormWidget(
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                        ),

                        SizedBox(height: 4.h),

                        // Social Login
                        SocialLoginWidget(
                          isLoading: _isLoading,
                          onGoogleLogin: () => _handleSocialLogin('Google'),
                          onFacebookLogin: () => _handleSocialLogin('Facebook'),
                        ),

                        Spacer(),

                        // Register Link
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿Usuario nuevo? ',
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textMediumEmphasisDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: _isLoading ? null : _navigateToRegister,
                                child: Text(
                                  'Registrarse',
                                  style: AppTheme.darkTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: AppTheme.accentTeal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Biometric Prompt Bottom Sheet
            if (_showBiometricPrompt)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Column(
                    children: [
                      Spacer(),
                      BiometricPromptWidget(
                        onBiometricLogin: _handleBiometricSetup,
                        onSkip: _skipBiometric,
                        biometricType: _biometricType,
                      ),
                    ],
                  ),
                ),
              ),

            // Loading Overlay
            if (_isLoading && !_showBiometricPrompt)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppTheme.darkTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.accentTeal),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Iniciando sesión...',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.surfaceWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
