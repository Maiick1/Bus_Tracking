import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ServiceAlertBanner extends StatefulWidget {
  final Map<String, dynamic> alert;

  const ServiceAlertBanner({
    Key? key,
    required this.alert,
  }) : super(key: key);

  @override
  State<ServiceAlertBanner> createState() => _ServiceAlertBannerState();
}

class _ServiceAlertBannerState extends State<ServiceAlertBanner> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final alertType = widget.alert['type'] as String;
    Color alertColor;
    IconData alertIcon;

    switch (alertType) {
      case 'warning':
        alertColor = AppTheme.warningAmber;
        alertIcon = Icons.warning;
        break;
      case 'error':
        alertColor = AppTheme.errorRed;
        alertIcon = Icons.error;
        break;
      case 'info':
        alertColor = AppTheme.infoBlue;
        alertIcon = Icons.info;
        break;
      default:
        alertColor = AppTheme.successGreen;
        alertIcon = Icons.check_circle;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alertColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: alertIcon.toString().split('.').last,
            color: alertColor,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.alert['title'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.surfaceWhite,
                  ),
                ),
                if (widget.alert['message'] != null) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    widget.alert['message'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.neutralGray,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(1.w),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.neutralGray,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ServiceAlertBanner extends StatefulWidget {
  final Map<String, dynamic> alert;

  const ServiceAlertBanner({
    Key? key,
    required this.alert,
  }) : super(key: key);

  @override
  State<ServiceAlertBanner> createState() => _ServiceAlertBannerState();
}

class _ServiceAlertBannerState extends State<ServiceAlertBanner> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final alertType = widget.alert['type'] as String;
    Color alertColor;
    IconData alertIcon;

    switch (alertType) {
      case 'warning':
        alertColor = AppTheme.warningAmber;
        alertIcon = Icons.warning;
        break;
      case 'error':
        alertColor = AppTheme.errorRed;
        alertIcon = Icons.error;
        break;
      case 'info':
        alertColor = AppTheme.infoBlue;
        alertIcon = Icons.info;
        break;
      default:
        alertColor = AppTheme.successGreen;
        alertIcon = Icons.check_circle;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alertColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: alertIcon.toString().split('.').last,
            color: alertColor,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.alert['title'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.surfaceWhite,
                  ),
                ),
                if (widget.alert['message'] != null) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    widget.alert['message'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.neutralGray,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(1.w),
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.neutralGray,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import '../../../core/theme/app_theme.dart'; 