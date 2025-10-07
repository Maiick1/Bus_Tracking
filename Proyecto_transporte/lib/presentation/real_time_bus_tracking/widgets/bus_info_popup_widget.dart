import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BusInfoPopupWidget extends StatelessWidget {
  final Map<String, dynamic> busData;
  final VoidCallback onClose;

  const BusInfoPopupWidget({
    Key? key,
    required this.busData,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderSubtle,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 1.5.h),
          _buildBusDetails(),
          SizedBox(height: 1.5.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.accentTeal,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                busData['busNumber'] as String,
                style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              busData['routeName'] as String,
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: AppTheme.neutralGray.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.neutralGray,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusDetails() {
    final delay = busData['delayMinutes'] as int;
    final occupancy = busData['occupancyPercentage'] as int;
    final speed = busData['currentSpeed'] as double;
    final lastUpdate = busData['lastUpdate'] as String;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                'Estado',
                delay > 0 ? 'Retrasado ${delay}min' : 'A tiempo',
                delay > 0 ? AppTheme.warningAmber : AppTheme.successGreen,
                delay > 0 ? 'warning' : 'check_circle',
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _buildDetailItem(
                'Ocupación',
                '$occupancy%',
                _getOccupancyColor(occupancy),
                'people',
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                'Velocidad',
                '${speed.toStringAsFixed(0)} km/h',
                AppTheme.infoBlue,
                'speed',
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _buildDetailItem(
                'Actualizado',
                lastUpdate,
                AppTheme.neutralGray,
                'update',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(
      String label, String value, Color color, String iconName) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderSubtle.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: color,
                size: 14,
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralGray,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Navigate to route details
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              side: BorderSide(color: AppTheme.accentTeal, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Ver Ruta',
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.accentTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Set notification for this bus
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentTeal,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Notificar',
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getOccupancyColor(int occupancy) {
    if (occupancy >= 80) {
      return AppTheme.errorRed;
    } else if (occupancy >= 60) {
      return AppTheme.warningAmber;
    } else {
      return AppTheme.successGreen;
    }
  }
}
