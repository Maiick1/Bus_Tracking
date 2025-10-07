import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SecuritySettingsWidget extends StatefulWidget {
  final bool biometricEnabled;
  final bool twoFactorEnabled;
  final Function(bool) onBiometricChanged;
  final Function(bool) onTwoFactorChanged;
  final VoidCallback onChangePassword;

  const SecuritySettingsWidget({
    Key? key,
    required this.biometricEnabled,
    required this.twoFactorEnabled,
    required this.onBiometricChanged,
    required this.onTwoFactorChanged,
    required this.onChangePassword,
  }) : super(key: key);

  @override
  State<SecuritySettingsWidget> createState() => _SecuritySettingsWidgetState();
}

class _SecuritySettingsWidgetState extends State<SecuritySettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seguridad',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionCard(
            child: Column(
              children: [
                _buildSecurityItem(
                  icon: 'lock',
                  title: 'Cambiar Contraseña',
                  subtitle: 'Actualiza tu contraseña de acceso',
                  onTap: widget.onChangePassword,
                  showArrow: true,
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildSecurityToggleItem(
                  icon: 'fingerprint',
                  title: 'Autenticación Biométrica',
                  subtitle: 'Usa huella dactilar o Face ID',
                  value: widget.biometricEnabled,
                  onChanged: widget.onBiometricChanged,
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildSecurityToggleItem(
                  icon: 'security',
                  title: 'Autenticación de Dos Factores',
                  subtitle: 'Protección adicional para tu cuenta',
                  value: widget.twoFactorEnabled,
                  onChanged: widget.onTwoFactorChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: child,
    );
  }

  Widget _buildSecurityItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.accentTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.accentTeal,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.surfaceWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              CustomIconWidget(
                iconName: 'chevron_right',
                color: AppTheme.neutralGray,
                size: 5.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityToggleItem({
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppTheme.accentTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.accentTeal,
              size: 5.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.surfaceWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  subtitle,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutralGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.accentTeal,
            activeTrackColor: AppTheme.accentTeal.withValues(alpha: 0.3),
            inactiveThumbColor: AppTheme.neutralGray,
            inactiveTrackColor: AppTheme.neutralGray.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
