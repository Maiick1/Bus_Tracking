import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class QrCodeWidget extends StatelessWidget {
  final String qrData;
  final bool isActive;

  const QrCodeWidget({
    Key? key,
    required this.qrData,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.w,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                painter: QRCodePainter(qrData),
              ),
            ),
          ),
          if (!isActive)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'block',
                      color: AppTheme.surfaceWhite,
                      size: 32,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Boleto Inactivo',
                      style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QRCodePainter extends CustomPainter {
  final String data;

  QRCodePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.surfaceWhite
      ..style = PaintingStyle.fill;

    // Simple QR code pattern simulation
    final cellSize = size.width / 25;

    // Create a basic QR code pattern
    final pattern = _generateQRPattern(data);

    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 25; j++) {
        if (pattern[i][j]) {
          canvas.drawRect(
            Rect.fromLTWH(
              j * cellSize,
              i * cellSize,
              cellSize,
              cellSize,
            ),
            paint,
          );
        }
      }
    }
  }

  List<List<bool>> _generateQRPattern(String data) {
    // Generate a pseudo-random pattern based on the data
    final pattern = List.generate(25, (i) => List.generate(25, (j) => false));

    // Add finder patterns (corners)
    _addFinderPattern(pattern, 0, 0);
    _addFinderPattern(pattern, 0, 18);
    _addFinderPattern(pattern, 18, 0);

    // Add some data pattern based on hash of input
    final hash = data.hashCode;
    for (int i = 8; i < 17; i++) {
      for (int j = 8; j < 17; j++) {
        pattern[i][j] = ((hash + i * j) % 3) == 0;
      }
    }

    return pattern;
  }

  void _addFinderPattern(List<List<bool>> pattern, int startX, int startY) {
    // 7x7 finder pattern
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 7; j++) {
        if (startX + i < 25 && startY + j < 25) {
          pattern[startX + i][startY + j] =
              (i == 0 || i == 6 || j == 0 || j == 6) ||
                  (i >= 2 && i <= 4 && j >= 2 && j <= 4);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
