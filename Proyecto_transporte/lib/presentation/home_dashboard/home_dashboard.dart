import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/location_header.dart';
import './widgets/popular_destinations_section.dart';
import './widgets/quick_access_tiles.dart';
import './widgets/service_alert_banner.dart';
import './widgets/ticket_purchase_card.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool _isLocationLoading = false;
  bool _isRefreshing = false;

  // Mock data for popular destinations
  final List<Map<String, dynamic>> _popularDestinations = [
    {
      "id": 1,
      "name": "Centro Histórico",
      "duration": "25 min",
      "image":
          "https://images.unsplash.com/photo-1555109307-f7d9da25c244?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    },
    {
      "id": 2,
      "name": "Terminal Terrestre",
      "duration": "35 min",
      "image":
          "https://images.pexels.com/photos/2219024/pexels-photo-2219024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      "id": 3,
      "name": "Parque La Carolina",
      "duration": "20 min",
      "image":
          "https://images.pixabay.com/photo/2016/11/29/05/45/architecture-1867187_1280.jpg",
    },
    {
      "id": 4,
      "name": "Aeropuerto",
      "duration": "45 min",
      "image":
          "https://images.unsplash.com/photo-1436491865332-7a61a109cc05?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    },
  ];

  // Mock service alert
  final Map<String, dynamic> _serviceAlert = {
    "type": "info",
    "title": "Servicio Normal",
    "message":
        "Todos los buses operan con normalidad. Próxima actualización en 15 min.",
  };

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    setState(() {
      _isLocationLoading = true;
    });

    // Simulate location loading
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLocationLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });

    // Show refresh feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Información actualizada',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppTheme.successGreen,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onTicketPurchaseTap() {
    Navigator.pushNamed(context, '/real-time-bus-tracking');
  }

  void _onDestinationTap(Map<String, dynamic> destination) {
    Navigator.pushNamed(context, '/real-time-bus-tracking');
  }

  void _onActiveTicketTap() {
    Navigator.pushNamed(context, '/qr-ticket-display');
  }

  void _onNearbyBusesTap() {
    Navigator.pushNamed(context, '/real-time-bus-tracking');
  }

  void _onRecentHistoryTap() {
    Navigator.pushNamed(context, '/user-profile');
  }

  void _onEmergencyContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.backgroundSecondary,
        title: Text(
          'Contacto de Emergencia',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.surfaceWhite,
          ),
        ),
        content: Text(
          '¿Deseas contactar con la autoridad de transporte?',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppTheme.neutralGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.neutralGray,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Emergency contact logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
            ),
            child: Text(
              'Llamar',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.surfaceWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryNavy,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: AppTheme.accentTeal,
          backgroundColor: AppTheme.backgroundSecondary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Header
                LocationHeader(
                  userName: 'María',
                  currentLocation: _isLocationLoading
                      ? 'Obteniendo ubicación...'
                      : 'Av. Amazonas y Naciones Unidas, Quito',
                  isLocationLoading: _isLocationLoading,
                ),

                // Service Alert Banner
                ServiceAlertBanner(alert: _serviceAlert),

                // Ticket Purchase Card
                TicketPurchaseCard(
                  onTap: _onTicketPurchaseTap,
                ),

                SizedBox(height: 2.h),

                // Popular Destinations Section
                PopularDestinationsSection(
                  destinations: _popularDestinations,
                  onDestinationTap: _onDestinationTap,
                ),

                SizedBox(height: 3.h),

                // Quick Access Tiles
                QuickAccessTiles(
                  onActiveTicketTap: _onActiveTicketTap,
                  onNearbyBusesTap: _onNearbyBusesTap,
                  onRecentHistoryTap: _onRecentHistoryTap,
                ),

                SizedBox(height: 2.h),

                // Additional Information Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.borderSubtle.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'info_outline',
                              color: AppTheme.infoBlue,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Información del Servicio',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.surfaceWhite,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        _buildInfoRow('Horario de Servicio', '05:00 - 23:00'),
                        SizedBox(height: 1.h),
                        _buildInfoRow('Frecuencia Promedio', '8-12 minutos'),
                        SizedBox(height: 1.h),
                        _buildInfoRow('Última Actualización', 'Hace 5 minutos'),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h), // Bottom padding for navigation
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onEmergencyContact,
        backgroundColor: AppTheme.errorRed,
        child: CustomIconWidget(
          iconName: 'phone',
          color: AppTheme.surfaceWhite,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppTheme.neutralGray,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.surfaceWhite,
          ),
        ),
      ],
    );
  }
}
