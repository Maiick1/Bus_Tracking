import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LocationHeader extends StatelessWidget {
  final String userName;
  final String currentLocation;
  final bool isLocationLoading;

  const LocationHeader({
    Key? key,
    required this.userName,
    required this.currentLocation,
    this.isLocationLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hola, $userName',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.surfaceWhite,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'location_on',
                      color: AppTheme.accentTeal,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: isLocationLoading
                          ? Text(
                              'Obteniendo ubicación...',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.neutralGray,
                              ),
                            )
                          : Text(
                              currentLocation,
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.neutralGray,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderSubtle.withValues(alpha: 0.3),
              ),
            ),
            child: CustomIconWidget(
              iconName: 'notifications_none',
              color: AppTheme.surfaceWhite,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';