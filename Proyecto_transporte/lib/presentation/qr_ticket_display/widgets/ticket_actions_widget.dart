import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TicketActionsWidget extends StatelessWidget {
  final VoidCallback? onShare;
  final VoidCallback? onSupport;
  final VoidCallback? onRefresh;

  const TicketActionsWidget({
    Key? key,
    this.onShare,
    this.onSupport,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Compartir Boleto',
                  'share',
                  AppTheme.accentTeal,
                  onShare ?? () => _handleShare(context),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildActionButton(
                  'Contactar Soporte',
                  'support_agent',
                  AppTheme.infoBlue,
                  onSupport ?? () => _handleSupport(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onRefresh ?? () => _handleRefresh(context),
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: AppTheme.accentTeal,
                size: 20,
              ),
              label: Text(
                'Actualizar Estado del Boleto',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.accentTeal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentTeal,
                side: BorderSide(color: AppTheme.accentTeal, width: 1),
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    String iconName,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: CustomIconWidget(
        iconName: iconName,
        color: AppTheme.surfaceWhite,
        size: 20,
      ),
      label: Text(
        label,
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.surfaceWhite,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppTheme.surfaceWhite,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  void _handleShare(BuildContext context) {
    HapticFeedback.lightImpact();

    // Generate shareable link
    final shareLink =
        'https://busticket.pro/ticket/BT${DateTime.now().millisecondsSinceEpoch}';

    Clipboard.setData(ClipboardData(text: shareLink));

    Fluttertoast.showToast(
      msg: "Enlace del boleto copiado al portapapeles",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.successGreen,
      textColor: AppTheme.surfaceWhite,
      fontSize: 14,
    );
  }

  void _handleSupport(BuildContext context) {
    HapticFeedback.lightImpact();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.darkTheme.colorScheme.surface,
          title: Text(
            'Contactar Soporte',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.darkTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Necesitas ayuda con tu boleto?',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
              SizedBox(height: 2.h),
              _buildSupportOption(
                'Llamar Soporte',
                'phone',
                '+593-2-123-4567',
              ),
              SizedBox(height: 1.h),
              _buildSupportOption(
                'WhatsApp',
                'chat',
                '+593-99-123-4567',
              ),
              SizedBox(height: 1.h),
              _buildSupportOption(
                'Email',
                'email',
                'soporte@busticket.pro',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cerrar',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.accentTeal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSupportOption(String label, String iconName, String contact) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.accentTeal,
          size: 20,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                contact,
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleRefresh(BuildContext context) {
    HapticFeedback.lightImpact();

    Fluttertoast.showToast(
      msg: "Actualizando estado del boleto...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.infoBlue,
      textColor: AppTheme.surfaceWhite,
      fontSize: 14,
    );

    // Simulate refresh delay
    Future.delayed(const Duration(seconds: 2), () {
      Fluttertoast.showToast(
        msg: "Estado del boleto actualizado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.successGreen,
        textColor: AppTheme.surfaceWhite,
        fontSize: 14,
      );
    });
  }
}
