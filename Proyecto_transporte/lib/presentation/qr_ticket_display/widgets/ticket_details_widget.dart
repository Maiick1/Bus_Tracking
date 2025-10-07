import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TicketDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> ticketData;

  const TicketDetailsWidget({
    Key? key,
    required this.ticketData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderSubtle.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticketData['routeName'] as String? ?? 'Ruta Desconocida',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.darkTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '${ticketData['origin'] as String? ?? 'Origen'} → ${ticketData['destination'] as String? ?? 'Destino'}',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(),
                  style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Hora de Salida',
                  ticketData['departureTime'] as String? ?? '--:--',
                  'schedule',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildInfoItem(
                  'Asiento/Zona',
                  ticketData['seatZone'] as String? ?? 'General',
                  'event_seat',
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  'Precio',
                  ticketData['price'] as String? ?? '\$0.00',
                  'attach_money',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildInfoItem(
                  'Válido hasta',
                  ticketData['validUntil'] as String? ?? '--/--/----',
                  'access_time',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, String iconName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: AppTheme.neutralGray,
              size: 16,
            ),
            SizedBox(width: 1.w),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.neutralGray,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.darkTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Color _getStatusColor() {
    final status = ticketData['status'] as String? ?? 'valid';
    switch (status.toLowerCase()) {
      case 'valid':
      case 'válido':
        return AppTheme.successGreen;
      case 'used':
      case 'usado':
        return AppTheme.neutralGray;
      case 'expired':
      case 'expirado':
        return AppTheme.errorRed;
      default:
        return AppTheme.neutralGray;
    }
  }

  String _getStatusText() {
    final status = ticketData['status'] as String? ?? 'valid';
    switch (status.toLowerCase()) {
      case 'valid':
        return 'Válido';
      case 'used':
        return 'Usado';
      case 'expired':
        return 'Expirado';
      default:
        return 'Válido';
    }
  }
}
