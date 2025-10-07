import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickAccessTiles extends StatelessWidget {
  final VoidCallback onActiveTicketTap;
  final VoidCallback onNearbyBusesTap;
  final VoidCallback onRecentHistoryTap;

  const QuickAccessTiles({
    Key? key,
    required this.onActiveTicketTap,
    required this.onNearbyBusesTap,
    required this.onRecentHistoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = [
      {
        'title': 'Mi Boleto\nActivo',
        'icon': 'qr_code',
        'color': AppTheme.successGreen,
        'onTap': onActiveTicketTap,
      },
      {
        'title': 'Buses\nCercanos',
        'icon': 'directions_bus',
        'color': AppTheme.infoBlue,
        'onTap': onNearbyBusesTap,
      },
      {
        'title': 'Historial\nReciente',
        'icon': 'history',
        'color': AppTheme.warningAmber,
        'onTap': onRecentHistoryTap,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: tiles.map((tile) {
          return Expanded(
            child: GestureDetector(
              onTap: tile['onTap'] as VoidCallback,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.borderSubtle.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: (tile['color'] as Color).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: tile['icon'] as String,
                        color: tile['color'] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      tile['title'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.surfaceWhite,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
import '../../../core/theme/app_theme.dart';  