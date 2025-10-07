import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AccountSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final VoidCallback onAddPaymentMethod;

  const AccountSectionWidget({
    Key? key,
    required this.paymentMethods,
    required this.onAddPaymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cuenta',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildSectionCard(
            title: 'Métodos de Pago',
            child: Column(
              children: [
                ...paymentMethods
                    .map((method) => _buildPaymentMethodItem(method))
                    .toList(),
                SizedBox(height: 2.h),
                _buildAddPaymentButton(),
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

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderSubtle.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: AppTheme.accentTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomIconWidget(
              iconName: method['type'] == 'credit_card'
                  ? 'credit_card'
                  : 'account_balance_wallet',
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
                  method['name'] as String,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.surfaceWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  method['details'] as String,
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
    );
  }

  Widget _buildAddPaymentButton() {
    return GestureDetector(
      onTap: onAddPaymentMethod,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.accentTeal.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.accentTeal.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'add',
              color: AppTheme.accentTeal,
              size: 5.w,
            ),
            SizedBox(width: 2.w),
            Text(
              'Agregar Método',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.accentTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
