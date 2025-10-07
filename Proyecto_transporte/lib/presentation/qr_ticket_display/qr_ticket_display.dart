import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/qr_code_widget.dart';
import './widgets/screen_brightness_widget.dart';
import './widgets/ticket_actions_widget.dart';
import './widgets/ticket_details_widget.dart';

class QrTicketDisplay extends StatefulWidget {
  const QrTicketDisplay({Key? key}) : super(key: key);

  @override
  State<QrTicketDisplay> createState() => _QrTicketDisplayState();
}

class _QrTicketDisplayState extends State<QrTicketDisplay> {
  PageController _pageController = PageController();
  int _currentTicketIndex = 0;
  bool _isRefreshing = false;

  // Mock ticket data
  final List<Map<String, dynamic>> _activeTickets = [
    {
      "id": "BT2025093001",
      "routeName": "Línea Norte Express",
      "origin": "Terminal Terrestre",
      "destination": "Centro Histórico",
      "departureTime": "14:30",
      "seatZone": "Zona A - Asiento 12",
      "price": "\$0.75",
      "validUntil": "30/09/2025 23:59",
      "status": "valid",
      "purchaseTime": "30/09/2025 13:45",
      "qrData": "BT2025093001-VALID-NORTE-EXPRESS",
      "fareBreakdown": {
        "baseFare": "\$0.60",
        "tax": "\$0.10",
        "serviceFee": "\$0.05",
        "total": "\$0.75"
      }
    },
    {
      "id": "BT2025093002",
      "routeName": "Ruta Sur Metropolitana",
      "origin": "Plaza Grande",
      "destination": "Terminal Sur",
      "departureTime": "16:15",
      "seatZone": "General",
      "price": "\$0.50",
      "validUntil": "30/09/2025 23:59",
      "status": "valid",
      "purchaseTime": "30/09/2025 15:30",
      "qrData": "BT2025093002-VALID-SUR-METRO",
      "fareBreakdown": {
        "baseFare": "\$0.45",
        "tax": "\$0.05",
        "serviceFee": "\$0.00",
        "total": "\$0.50"
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _preventScreenCapture();
  }

  @override
  void dispose() {
    _enableScreenCapture();
    _pageController.dispose();
    super.dispose();
  }

  void _preventScreenCapture() {
    // Prevent screenshots for security
    try {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } catch (e) {
      // Handle silently
    }
  }

  void _enableScreenCapture() {
    try {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } catch (e) {
      // Handle silently
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.darkTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.darkTheme.appBarTheme.foregroundColor!,
            size: 24,
          ),
        ),
        title: Text(
          'Mi Boleto',
          style: AppTheme.darkTheme.appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: _handleRefreshTickets,
            icon: _isRefreshing
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.darkTheme.appBarTheme.foregroundColor!,
                      ),
                    ),
                  )
                : CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.darkTheme.appBarTheme.foregroundColor!,
                    size: 24,
                  ),
          ),
        ],
      ),
      body: _activeTickets.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _handleRefreshTickets,
              color: AppTheme.accentTeal,
              backgroundColor: AppTheme.darkTheme.colorScheme.surface,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    if (_activeTickets.length > 1) _buildTicketIndicator(),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 85.h,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentTicketIndex = index;
                          });
                          HapticFeedback.lightImpact();
                        },
                        itemCount: _activeTickets.length,
                        itemBuilder: (context, index) {
                          return _buildTicketPage(_activeTickets[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'confirmation_number',
              color: AppTheme.neutralGray,
              size: 64,
            ),
            SizedBox(height: 3.h),
            Text(
              'No tienes boletos activos',
              style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.darkTheme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Compra un boleto para comenzar tu viaje',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.neutralGray,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/home-dashboard'),
              icon: CustomIconWidget(
                iconName: 'add_shopping_cart',
                color: AppTheme.surfaceWhite,
                size: 20,
              ),
              label: Text(
                'Comprar Boleto',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentTeal,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Boleto ${_currentTicketIndex + 1} de ${_activeTickets.length}',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.neutralGray,
            ),
          ),
          SizedBox(width: 4.w),
          Row(
            children: List.generate(
              _activeTickets.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentTicketIndex
                      ? AppTheme.accentTeal
                      : AppTheme.borderSubtle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketPage(Map<String, dynamic> ticketData) {
    final isValidTicket =
        (ticketData['status'] as String).toLowerCase() == 'valid';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Ticket Details
          TicketDetailsWidget(ticketData: ticketData),
          SizedBox(height: 3.h),

          // QR Code
          QrCodeWidget(
            qrData: ticketData['qrData'] as String,
            isActive: isValidTicket,
          ),
          SizedBox(height: 3.h),

          // Screen Brightness Controls
          const ScreenBrightnessWidget(),
          SizedBox(height: 3.h),

          // Ticket Actions
          TicketActionsWidget(
            onShare: () => _handleShareTicket(ticketData),
            onSupport: () => _handleContactSupport(ticketData),
            onRefresh: _handleRefreshTickets,
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefreshTickets() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Update ticket status (simulate server validation)
    for (var ticket in _activeTickets) {
      final now = DateTime.now();
      final purchaseTime = DateTime.now().subtract(const Duration(hours: 1));

      if (now.difference(purchaseTime).inHours > 24) {
        ticket['status'] = 'expired';
      }
    }

    setState(() {
      _isRefreshing = false;
    });

    HapticFeedback.lightImpact();
  }

  void _handleShareTicket(Map<String, dynamic> ticketData) {
    HapticFeedback.lightImpact();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.darkTheme.colorScheme.surface,
          title: Text(
            'Compartir Boleto',
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
                'Genera un enlace seguro para compartir este boleto con familiares.',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.borderSubtle.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.infoBlue,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'El enlace será válido por 24 horas',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.infoBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutralGray,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle share logic from TicketActionsWidget
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentTeal,
              ),
              child: Text(
                'Generar Enlace',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleContactSupport(Map<String, dynamic> ticketData) {
    HapticFeedback.lightImpact();
    // This is handled by TicketActionsWidget
  }
}
