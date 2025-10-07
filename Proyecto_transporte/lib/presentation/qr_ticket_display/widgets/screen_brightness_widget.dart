import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ScreenBrightnessWidget extends StatefulWidget {
  const ScreenBrightnessWidget({Key? key}) : super(key: key);

  @override
  State<ScreenBrightnessWidget> createState() => _ScreenBrightnessWidgetState();
}

class _ScreenBrightnessWidgetState extends State<ScreenBrightnessWidget> {
  bool _keepScreenOn = false;
  double _currentBrightness = 0.8;
  double _originalBrightness = 0.5;

  @override
  void initState() {
    super.initState();
    _initializeBrightness();
  }

  Future<void> _initializeBrightness() async {
    try {
      final brightness = await ScreenBrightness().current;
      setState(() {
        _originalBrightness = brightness;
        _currentBrightness = brightness;
      });
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  void dispose() {
    _restoreOriginalBrightness();
    super.dispose();
  }

  Future<void> _restoreOriginalBrightness() async {
    try {
      await ScreenBrightness().setScreenBrightness(_originalBrightness);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
      setState(() {
        _currentBrightness = brightness;
      });
    } catch (e) {
      // Handle error silently
    }
  }

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
            children: [
              CustomIconWidget(
                iconName: 'brightness_6',
                color: AppTheme.accentTeal,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Configuración de Pantalla',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.darkTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'brightness_low',
                color: AppTheme.neutralGray,
                size: 16,
              ),
              Expanded(
                child: Slider(
                  value: _currentBrightness,
                  min: 0.1,
                  max: 1.0,
                  divisions: 9,
                  onChanged: (value) {
                    _setBrightness(value);
                  },
                  activeColor: AppTheme.accentTeal,
                  inactiveColor: AppTheme.borderSubtle,
                ),
              ),
              CustomIconWidget(
                iconName: 'brightness_high',
                color: AppTheme.neutralGray,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mantener pantalla activa',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.darkTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Evita que la pantalla se apague',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _keepScreenOn,
                onChanged: (value) {
                  setState(() {
                    _keepScreenOn = value;
                  });
                  _handleKeepScreenOn(value);
                },
                activeColor: AppTheme.accentTeal,
                inactiveThumbColor: AppTheme.neutralGray,
                inactiveTrackColor: AppTheme.borderSubtle,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickBrightnessButton(
                  'Bajo',
                  'brightness_low',
                  0.3,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildQuickBrightnessButton(
                  'Medio',
                  'brightness_medium',
                  0.6,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildQuickBrightnessButton(
                  'Alto',
                  'brightness_high',
                  1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickBrightnessButton(
    String label,
    String iconName,
    double brightness,
  ) {
    final isSelected = (_currentBrightness - brightness).abs() < 0.1;

    return GestureDetector(
      onTap: () => _setBrightness(brightness),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentTeal.withValues(alpha: 0.2)
              : AppTheme.borderSubtle.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentTeal
                : AppTheme.borderSubtle.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: isSelected ? AppTheme.accentTeal : AppTheme.neutralGray,
              size: 20,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color: isSelected ? AppTheme.accentTeal : AppTheme.neutralGray,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleKeepScreenOn(bool keepOn) {
    // This would integrate with a wake lock plugin in a real implementation
    // For now, we'll just show the state change
  }
}
    