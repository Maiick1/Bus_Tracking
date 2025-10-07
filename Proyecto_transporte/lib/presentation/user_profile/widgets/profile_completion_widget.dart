import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileCompletionWidget extends StatelessWidget {
  final double completionPercentage;
  final List<String> missingFields;

  const ProfileCompletionWidget({
    Key? key,
    required this.completionPercentage,
    required this.missingFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (completionPercentage >= 100) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentTeal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'account_circle',
                color: AppTheme.accentTeal,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Completa tu Perfil',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.surfaceWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${completionPercentage.toInt()}%',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.accentTeal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            height: 1.h,
            decoration: BoxDecoration(
              color: AppTheme.borderSubtle,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: completionPercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.accentTeal,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Campos faltantes:',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralGray,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: missingFields
                .map((field) => _buildMissingFieldChip(field))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMissingFieldChip(String field) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.warningAmber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.warningAmber.withValues(alpha: 0.3)),
      ),
      child: Text(
        field,
        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.warningAmber,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
