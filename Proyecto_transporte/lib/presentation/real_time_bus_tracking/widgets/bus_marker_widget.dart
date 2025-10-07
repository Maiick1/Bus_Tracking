import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BusMarkerWidget extends StatelessWidget {
  final String busNumber;
  final String routeName;
  final int occupancyPercentage;
  final int delayMinutes;
  final VoidCallback onTap;

  const BusMarkerWidget({
    Key? key,
    required this.busNumber,
    required this.routeName,
    required this.occupancyPercentage,
    required this.delayMinutes,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: _getBusStatusColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.surfaceWhite,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'directions_bus',
              color: AppTheme.surfaceWhite,
              size: 16,
            ),
            SizedBox(height: 0.2.h),
            Text(
              busNumber,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w600,
                fontSize: 8.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getBusStatusColor() {
    if (delayMinutes > 10) {
      return AppTheme.errorRed;
    } else if (delayMinutes > 5) {
      return AppTheme.warningAmber;
    } else {
      return AppTheme.successGreen;
    }
  }
}
