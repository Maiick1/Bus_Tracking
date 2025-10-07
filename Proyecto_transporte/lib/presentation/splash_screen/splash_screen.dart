import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _loadingAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _loadingFadeAnimation;

  bool _showLoading = false;
  bool _showOfflineOption = false;
  String _loadingText = 'Iniciando BusTicket Pro...';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Loading animation controller
    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Loading fade animation
    _loadingFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingAnimationController,
      curve: Curves.easeIn,
    ));
  }

  void _startSplashSequence() async {
    // Start logo animation
    _logoAnimationController.forward();

    // Wait for logo animation to complete
    await Future.delayed(const Duration(milliseconds: 1500));

    // Show loading indicator
    setState(() {
      _showLoading = true;
    });
    _loadingAnimationController.forward();

    // Simulate initialization tasks
    await _performInitializationTasks();
  }

  Future<void> _performInitializationTasks() async {
    try {
      // Task 1: Check authentication status
      setState(() {
        _loadingText = 'Verificando autenticación...';
      });
      await Future.delayed(const Duration(milliseconds: 600));

      // Task 2: Load cached ticket data
      setState(() {
        _loadingText = 'Cargando boletos guardados...';
      });
      await Future.delayed(const Duration(milliseconds: 500));

      // Task 3: Fetch real-time bus schedules
      setState(() {
        _loadingText = 'Actualizando horarios de buses...';
      });
      await Future.delayed(const Duration(milliseconds: 700));

      // Task 4: Prepare offline maps
      setState(() {
        _loadingText = 'Preparando mapas offline...';
      });
      await Future.delayed(const Duration(milliseconds: 500));

      // Task 5: Check for app updates
      setState(() {
        _loadingText = 'Verificando actualizaciones...';
      });
      await Future.delayed(const Duration(milliseconds: 400));

      // Navigation logic
      _navigateToNextScreen();
    } catch (e) {
      // Handle initialization errors
      _handleInitializationError();
    }

    // Show offline option after 5 seconds if still loading
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showOfflineOption = true;
        });
      }
    });
  }

  void _navigateToNextScreen() {
    // Simulate authentication check
    bool isAuthenticated = _checkAuthenticationStatus();
    bool isFirstTime = _checkFirstTimeUser();

    if (isAuthenticated) {
      // Navigate to home dashboard
      Navigator.pushReplacementNamed(context, '/home-dashboard');
    } else if (isFirstTime) {
      // Navigate to onboarding (for now, go to login)
      Navigator.pushReplacementNamed(context, '/login-screen');
    } else {
      // Navigate to login screen
      Navigator.pushReplacementNamed(context, '/login-screen');
    }
  }

  bool _checkAuthenticationStatus() {
    // Mock authentication check
    // In real app, check stored tokens/credentials
    return false;
  }

  bool _checkFirstTimeUser() {
    // Mock first time user check
    // In real app, check shared preferences
    return true;
  }

  void _handleInitializationError() {
    setState(() {
      _loadingText = 'Error de conexión';
      _showOfflineOption = true;
    });
  }

  void _continueOffline() {
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryNavy,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryNavy,
                AppTheme.backgroundSecondary,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Logo Section
                      AnimatedBuilder(
                        animation: _logoAnimationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScaleAnimation.value,
                            child: Opacity(
                              opacity: _logoFadeAnimation.value,
                              child: _buildAppLogo(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 8.h),

                      // Loading Section
                      _showLoading
                          ? AnimatedBuilder(
                              animation: _loadingAnimationController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _loadingFadeAnimation.value,
                                  child: _buildLoadingSection(),
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),

              // Bottom Section
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        color: AppTheme.accentTeal,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentTeal.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'directions_bus',
            color: AppTheme.surfaceWhite,
            size: 12.w,
          ),
          SizedBox(height: 1.h),
          Text(
            'BTP',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.surfaceWhite,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      children: [
        // Loading Indicator
        SizedBox(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentTeal),
            backgroundColor: AppTheme.borderSubtle,
          ),
        ),

        SizedBox(height: 3.h),

        // Loading Text
        Text(
          _loadingText,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppTheme.textMediumEmphasisDark,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 2.h),

        // Offline Option
        _showOfflineOption ? _buildOfflineOption() : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildOfflineOption() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Text(
            'Problemas de conexión detectados',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: AppTheme.warningAmber,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          TextButton(
            onPressed: _continueOffline,
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.backgroundSecondary,
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 1.5.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: AppTheme.borderSubtle,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              'Continuar sin conexión',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.accentTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      child: Column(
        children: [
          // App Name
          Text(
            'BusTicket Pro',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.surfaceWhite,
              letterSpacing: 0.5,
            ),
          ),

          SizedBox(height: 1.h),

          // Tagline
          Text(
            'Tu transporte público digitalizado',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: AppTheme.textMediumEmphasisDark,
            ),
          ),

          SizedBox(height: 2.h),

          // Version and Copyright
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'v1.0.0',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textDisabledDark,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                width: 1,
                height: 3.w,
                color: AppTheme.borderSubtle,
              ),
              Text(
                '© 2024 BusTicket Pro',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textDisabledDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
