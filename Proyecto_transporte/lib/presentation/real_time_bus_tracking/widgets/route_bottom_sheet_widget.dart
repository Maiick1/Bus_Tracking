import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RouteBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> routeData;
  final VoidCallback onRefresh;
  final Function(bool) onExpansionChanged;

  const RouteBottomSheetWidget({
    Key? key,
    required this.routeData,
    required this.onRefresh,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  State<RouteBottomSheetWidget> createState() => _RouteBottomSheetWidgetState();
}

class _RouteBottomSheetWidgetState extends State<RouteBottomSheetWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundSecondary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDragHandle(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    widget.onRefresh();
                  },
                  child: ListView(
                    controller: scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    children: [
                      _buildRouteHeader(),
                      SizedBox(height: 2.h),
                      _buildBusInfo(),
                      SizedBox(height: 2.h),
                      _buildNextStopsSection(),
                      if (_isExpanded) ...[
                        SizedBox(height: 2.h),
                        _buildFullRouteTimeline(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 12.w,
      height: 0.6.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.neutralGray,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildRouteHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.accentTeal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.routeData['busNumber'] as String,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.routeData['routeName'] as String,
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Hacia ${widget.routeData['destination']}',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
            ],
          ),
        ),
        CustomIconWidget(
          iconName: 'refresh',
          color: AppTheme.accentTeal,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildBusInfo() {
    final occupancy = widget.routeData['occupancyPercentage'] as int;
    final delay = widget.routeData['delayMinutes'] as int;
    final eta = widget.routeData['estimatedArrival'] as String;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderSubtle,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                'Llegada Estimada',
                eta,
                CustomIconWidget(
                  iconName: 'access_time',
                  color: AppTheme.accentTeal,
                  size: 16,
                ),
              ),
              _buildInfoItem(
                'Ocupación',
                '$occupancy%',
                CustomIconWidget(
                  iconName: 'people',
                  color: _getOccupancyColor(occupancy),
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                'Estado',
                delay > 0 ? 'Retrasado ${delay}min' : 'A tiempo',
                CustomIconWidget(
                  iconName: delay > 0 ? 'warning' : 'check_circle',
                  color:
                      delay > 0 ? AppTheme.warningAmber : AppTheme.successGreen,
                  size: 16,
                ),
              ),
              _buildInfoItem(
                'Distancia',
                '${widget.routeData['distanceToStop']} m',
                CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.infoBlue,
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Widget icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 1.w),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.neutralGray,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.surfaceWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildNextStopsSection() {
    final nextStops =
        widget.routeData['nextStops'] as List<Map<String, dynamic>>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Próximas Paradas',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                widget.onExpansionChanged(_isExpanded);
              },
              child: Text(
                _isExpanded ? 'Ver menos' : 'Ver ruta completa',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.accentTeal,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ...nextStops.take(3).map((stop) => _buildStopItem(stop, false)),
      ],
    );
  }

  Widget _buildFullRouteTimeline() {
    final allStops = widget.routeData['allStops'] as List<Map<String, dynamic>>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ruta Completa',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.surfaceWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        ...allStops
            .map((stop) => _buildStopItem(stop, stop['isPassed'] as bool)),
      ],
    );
  }

  Widget _buildStopItem(Map<String, dynamic> stop, bool isPassed) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 3.w,
            decoration: BoxDecoration(
              color: isPassed ? AppTheme.neutralGray : AppTheme.accentTeal,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stop['name'] as String,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color:
                        isPassed ? AppTheme.neutralGray : AppTheme.surfaceWhite,
                    fontWeight: isPassed ? FontWeight.w400 : FontWeight.w500,
                  ),
                ),
                if (stop['eta'] != null)
                  Text(
                    stop['eta'] as String,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
                  ),
              ],
            ),
          ),
          if (stop['isUserStop'] == true)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.accentTeal.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppTheme.accentTeal,
                  width: 1,
                ),
              ),
              child: Text(
                'Tu parada',
                style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.accentTeal,
                  fontSize: 8.sp,
                ),
              ),
            ),
        ],
      ),
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
