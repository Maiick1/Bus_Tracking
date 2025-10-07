import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PreferencesWidget extends StatefulWidget {
  final bool darkModeEnabled;
  final String selectedLanguage;
  final Map<String, bool> notificationSettings;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;
  final Function(String, bool) onNotificationChanged;

  const PreferencesWidget({
    Key? key,
    required this.darkModeEnabled,
    required this.selectedLanguage,
    required this.notificationSettings,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
    required this.onNotificationChanged,
  }) : super(key: key);

  @override
  State<PreferencesWidget> createState() => _PreferencesWidgetState();
}

class _PreferencesWidgetState extends State<PreferencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferencias',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionCard(
            title: 'Apariencia',
            child: Column(
              children: [
                _buildToggleItem(
                  icon: 'dark_mode',
                  title: 'Modo Oscuro',
                  subtitle: 'Cambia el tema de la aplicación',
                  value: widget.darkModeEnabled,
                  onChanged: widget.onDarkModeChanged,
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildLanguageSelector(),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionCard(
            title: 'Notificaciones',
            child: Column(
              children: [
                _buildToggleItem(
                  icon: 'notifications',
                  title: 'Notificaciones Push',
                  subtitle: 'Recibe alertas en tiempo real',
                  value: widget.notificationSettings['push'] ?? true,
                  onChanged: (value) =>
                      widget.onNotificationChanged('push', value),
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildToggleItem(
                  icon: 'email',
                  title: 'Notificaciones por Email',
                  subtitle: 'Recibe actualizaciones por correo',
                  value: widget.notificationSettings['email'] ?? false,
                  onChanged: (value) =>
                      widget.onNotificationChanged('email', value),
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildToggleItem(
                  icon: 'sms',
                  title: 'Notificaciones SMS',
                  subtitle: 'Recibe alertas por mensaje de texto',
                  value: widget.notificationSettings['sms'] ?? false,
                  onChanged: (value) =>
                      widget.onNotificationChanged('sms', value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          child,
        ],
      ),
    );
  }

  Widget _buildToggleItem({
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

  Widget _buildLanguageSelector() {
    return GestureDetector(
      onTap: _showLanguageDialog,
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
                iconName: 'language',
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
                    'Idioma',
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.surfaceWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    widget.selectedLanguage == 'es' ? 'Español' : 'English',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralGray,
                    ),
                  ),
                ],
              ),
            ),
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

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundSecondary,
          title: Text(
            'Seleccionar Idioma',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('es', 'Español'),
              _buildLanguageOption('en', 'English'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    final isSelected = widget.selectedLanguage == code;
    return GestureDetector(
      onTap: () {
        widget.onLanguageChanged(code);
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        margin: EdgeInsets.only(bottom: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentTeal.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentTeal
                : AppTheme.borderSubtle.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Text(
              name,
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: isSelected ? AppTheme.accentTeal : AppTheme.surfaceWhite,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            Spacer(),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check',
                color: AppTheme.accentTeal,
                size: 5.w,
              ),
          ],
        ),
      ),
    );
  }
}
