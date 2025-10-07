import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BiometricPromptWidget extends StatelessWidget {
  final Function() onBiometricLogin;
  final Function() onSkip;
  final String biometricType;

  const BiometricPromptWidget({
    Key? key,
    required this.onBiometricLogin,
    required this.onSkip,
    required this.biometricType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(height: 3.h),

          // Biometric Icon
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppTheme.accentTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: biometricType == 'face' ? 'face' : 'fingerprint',
                color: AppTheme.accentTeal,
                size: 10.w,
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Title
          Text(
            'Acceso Biométrico',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 1.h),

          // Description
          Text(
            biometricType == 'face'
                ? 'Usa Face ID para acceder más rápido a tu cuenta'
                : 'Usa tu huella dactilar para acceder más rápido a tu cuenta',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisDark,
            ),
          ),

          SizedBox(height: 4.h),

          // Enable Biometric Button
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: onBiometricLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentTeal,
                foregroundColor: AppTheme.surfaceWhite,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Habilitar ${biometricType == 'face' ? 'Face ID' : 'Huella Dactilar'}',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Skip Button
          TextButton(
            onPressed: onSkip,
            child: Text(
              'Ahora no',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.neutralGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
