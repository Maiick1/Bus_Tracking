import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo Container
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: AppTheme.accentTeal,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentTeal.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bus Icon
              CustomIconWidget(
                iconName: 'directions_bus',
                color: AppTheme.surfaceWhite,
                size: 12.w,
              ),
              // Ticket overlay
              Positioned(
                bottom: 4.w,
                right: 4.w,
                child: Container(
                  width: 6.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: CustomIconWidget(
                    iconName: 'qr_code',
                    color: AppTheme.accentTeal,
                    size: 3.w,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 3.h),

        // App Name
        Text(
          'BusTicket Pro',
          style: AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.surfaceWhite,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),

        SizedBox(height: 1.h),

        // App Tagline
        Text(
          'Tu transporte público inteligente',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textMediumEmphasisDark,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
