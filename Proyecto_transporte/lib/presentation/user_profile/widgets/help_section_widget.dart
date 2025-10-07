import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HelpSectionWidget extends StatelessWidget {
  final VoidCallback onFaqPressed;
  final VoidCallback onContactPressed;
  final VoidCallback onTutorialPressed;

  const HelpSectionWidget({
    Key? key,
    required this.onFaqPressed,
    required this.onContactPressed,
    required this.onTutorialPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ayuda y Soporte',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionCard(
            child: Column(
              children: [
                _buildHelpItem(
                  icon: 'help_outline',
                  title: 'Preguntas Frecuentes',
                  subtitle: 'Encuentra respuestas rápidas',
                  onTap: onFaqPressed,
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildHelpItem(
                  icon: 'support_agent',
                  title: 'Contactar Soporte',
                  subtitle: 'Habla con nuestro equipo',
                  onTap: onContactPressed,
                ),
                Divider(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
                _buildHelpItem(
                  icon: 'play_circle_outline',
                  title: 'Videos Tutoriales',
                  subtitle: 'Aprende a usar la app',
                  onTap: onTutorialPressed,
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

  Widget _buildHelpItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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
                color: AppTheme.infoBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.infoBlue,
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
}
