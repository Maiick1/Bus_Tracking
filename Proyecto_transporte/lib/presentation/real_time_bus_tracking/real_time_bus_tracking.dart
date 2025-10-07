import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bus_info_popup_widget.dart';
import './widgets/route_bottom_sheet_widget.dart';

class RealTimeBusTracking extends StatefulWidget {
  const RealTimeBusTracking({Key? key}) : super(key: key);

  @override
  State<RealTimeBusTracking> createState() => _RealTimeBusTrackingState();
}

class _RealTimeBusTrackingState extends State<RealTimeBusTracking>
    with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Timer? _trackingTimer;
  bool _isLoading = true;
  bool _isTrackingEnabled = true;
  Map<String, dynamic>? _selectedBus;
  String? _selectedRouteId;

  // Animation controllers
  late AnimationController _busAnimationController;
  late AnimationController _pulseAnimationController;

  // Map markers and polylines
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  // Mock data for buses and routes
  final List<Map<String, dynamic>> _busData = [
    {
      "id": "bus_001",
      "busNumber": "101",
      "routeName": "Centro - Terminal",
      "destination": "Terminal Terrestre",
      "currentLat": -0.2298500,
      "currentLng": -78.5249500,
      "occupancyPercentage": 65,
      "delayMinutes": 3,
      "estimatedArrival": "5 min",
      "distanceToStop": 250,
      "currentSpeed": 25.5,
      "lastUpdate": "Hace 30s",
      "nextStops": [
        {
          "name": "Plaza Grande",
          "eta": "2 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "La Marín",
          "eta": "5 min",
          "isUserStop": true,
          "isPassed": false
        },
        {
          "name": "El Ejido",
          "eta": "8 min",
          "isUserStop": false,
          "isPassed": false
        },
      ],
      "allStops": [
        {
          "name": "Terminal Norte",
          "eta": null,
          "isUserStop": false,
          "isPassed": true
        },
        {"name": "La Y", "eta": null, "isUserStop": false, "isPassed": true},
        {
          "name": "Plaza Grande",
          "eta": "2 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "La Marín",
          "eta": "5 min",
          "isUserStop": true,
          "isPassed": false
        },
        {
          "name": "El Ejido",
          "eta": "8 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Terminal Terrestre",
          "eta": "15 min",
          "isUserStop": false,
          "isPassed": false
        },
      ]
    },
    {
      "id": "bus_002",
      "busNumber": "205",
      "routeName": "Norte - Sur",
      "destination": "Quitumbe",
      "currentLat": -0.2198500,
      "currentLng": -78.5149500,
      "occupancyPercentage": 85,
      "delayMinutes": 8,
      "estimatedArrival": "12 min",
      "distanceToStop": 800,
      "currentSpeed": 18.2,
      "lastUpdate": "Hace 1min",
      "nextStops": [
        {
          "name": "Universidad Central",
          "eta": "3 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "El Recreo",
          "eta": "8 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Quitumbe",
          "eta": "15 min",
          "isUserStop": false,
          "isPassed": false
        },
      ],
      "allStops": [
        {
          "name": "Carcelén",
          "eta": null,
          "isUserStop": false,
          "isPassed": true
        },
        {
          "name": "La Ofelia",
          "eta": null,
          "isUserStop": false,
          "isPassed": true
        },
        {
          "name": "Universidad Central",
          "eta": "3 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "El Recreo",
          "eta": "8 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Quitumbe",
          "eta": "15 min",
          "isUserStop": false,
          "isPassed": false
        },
      ]
    },
    {
      "id": "bus_003",
      "busNumber": "301",
      "routeName": "Aeropuerto - Centro",
      "destination": "Centro Histórico",
      "currentLat": -0.2398500,
      "currentLng": -78.5349500,
      "occupancyPercentage": 42,
      "delayMinutes": 0,
      "estimatedArrival": "8 min",
      "distanceToStop": 450,
      "currentSpeed": 32.1,
      "lastUpdate": "Hace 15s",
      "nextStops": [
        {
          "name": "Parque La Carolina",
          "eta": "4 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Plaza Foch",
          "eta": "6 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Centro Histórico",
          "eta": "10 min",
          "isUserStop": false,
          "isPassed": false
        },
      ],
      "allStops": [
        {
          "name": "Aeropuerto",
          "eta": null,
          "isUserStop": false,
          "isPassed": true
        },
        {
          "name": "Tababela",
          "eta": null,
          "isUserStop": false,
          "isPassed": true
        },
        {
          "name": "Parque La Carolina",
          "eta": "4 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Plaza Foch",
          "eta": "6 min",
          "isUserStop": false,
          "isPassed": false
        },
        {
          "name": "Centro Histórico",
          "eta": "10 min",
          "isUserStop": false,
          "isPassed": false
        },
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _getCurrentLocation();
    _startBusTracking();
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    _busAnimationController.dispose();
    _pulseAnimationController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _busAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationError();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      _updateMapMarkers();
      _centerMapOnUser();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showLocationError();
    }
  }

  void _startBusTracking() {
    _trackingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isTrackingEnabled) {
        _updateBusPositions();
      }
    });
  }

  void _updateBusPositions() {
    // Simulate bus movement with small random changes
    for (var bus in _busData) {
      final random = DateTime.now().millisecondsSinceEpoch % 100;
      bus['currentLat'] =
          (bus['currentLat'] as double) + (random - 50) * 0.0001;
      bus['currentLng'] =
          (bus['currentLng'] as double) + (random - 50) * 0.0001;

      // Update last update timestamp
      bus['lastUpdate'] = 'Hace ${(random % 60)}s';
    }

    _updateMapMarkers();
    HapticFeedback.lightImpact();
  }

  void _updateMapMarkers() {
    Set<Marker> newMarkers = {};

    // Add user location marker
    if (_currentPosition != null) {
      newMarkers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: 'Mi Ubicación',
            snippet: 'Tu ubicación actual',
          ),
        ),
      );
    }

    // Add bus markers
    for (var bus in _busData) {
      newMarkers.add(
        Marker(
          markerId: MarkerId(bus['id'] as String),
          position:
              LatLng(bus['currentLat'] as double, bus['currentLng'] as double),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _getBusMarkerColor(bus['delayMinutes'] as int),
          ),
          onTap: () => _showBusInfoPopup(bus),
          infoWindow: InfoWindow(
            title: 'Bus ${bus['busNumber']}',
            snippet: bus['routeName'] as String,
          ),
        ),
      );
    }

    // Add route polylines if a route is selected
    if (_selectedRouteId != null) {
      _addRoutePolylines();
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  double _getBusMarkerColor(int delayMinutes) {
    if (delayMinutes > 10) {
      return BitmapDescriptor.hueRed;
    } else if (delayMinutes > 5) {
      return BitmapDescriptor.hueOrange;
    } else {
      return BitmapDescriptor.hueGreen;
    }
  }

  void _addRoutePolylines() {
    // Mock route polyline coordinates
    final List<LatLng> routeCoordinates = [
      const LatLng(-0.2398500, -78.5349500),
      const LatLng(-0.2298500, -78.5249500),
      const LatLng(-0.2198500, -78.5149500),
      const LatLng(-0.2098500, -78.5049500),
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId(_selectedRouteId!),
          points: routeCoordinates,
          color: AppTheme.accentTeal,
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      );
    });
  }

  void _centerMapOnUser() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          15.0,
        ),
      );
    }
  }

  void _showBusInfoPopup(Map<String, dynamic> busData) {
    setState(() {
      _selectedBus = busData;
    });

    HapticFeedback.selectionClick();
  }

  void _showLocationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'No se pudo obtener la ubicación. Verifica los permisos.'),
        backgroundColor: AppTheme.errorRed,
        action: SnackBarAction(
          label: 'Reintentar',
          textColor: AppTheme.surfaceWhite,
          onPressed: _getCurrentLocation,
        ),
      ),
    );
  }

  void _refreshTracking() {
    HapticFeedback.mediumImpact();
    _updateBusPositions();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos de seguimiento actualizados'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryNavy,
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingState() : _buildMapView(),
      floatingActionButton: _buildFloatingActionButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.primaryNavy,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.surfaceWhite,
          size: 24,
        ),
      ),
      title: Text(
        'Seguimiento en Tiempo Real',
        style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
          color: AppTheme.surfaceWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _isTrackingEnabled = !_isTrackingEnabled;
            });
            HapticFeedback.lightImpact();
          },
          icon: CustomIconWidget(
            iconName: _isTrackingEnabled ? 'pause' : 'play_arrow',
            color: _isTrackingEnabled
                ? AppTheme.warningAmber
                : AppTheme.successGreen,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: _refreshTracking,
          icon: CustomIconWidget(
            iconName: 'refresh',
            color: AppTheme.accentTeal,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentTeal),
          ),
          SizedBox(height: 2.h),
          Text(
            'Obteniendo ubicación...',
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.surfaceWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            _updateMapMarkers();
          },
          initialCameraPosition: CameraPosition(
            target: _currentPosition != null
                ? LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude)
                : const LatLng(-0.2298500, -78.5249500), // Quito coordinates
            zoom: 13.0,
          ),
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          trafficEnabled: false,
          buildingsEnabled: true,
          onTap: (LatLng position) {
            setState(() {
              _selectedBus = null;
            });
          },
          style: '''
            [
              {
                "elementType": "geometry",
                "stylers": [
                  {
                    "color": "#1a1a2e"
                  }
                ]
              },
              {
                "elementType": "labels.text.fill",
                "stylers": [
                  {
                    "color": "#ffffff"
                  }
                ]
              },
              {
                "elementType": "labels.text.stroke",
                "stylers": [
                  {
                    "color": "#1a1a2e"
                  }
                ]
              }
            ]
          ''',
        ),
        if (_selectedBus != null) _buildBusInfoOverlay(),
        _buildBottomSheet(),
      ],
    );
  }

  Widget _buildBusInfoOverlay() {
    return Positioned(
      top: 2.h,
      left: 4.w,
      right: 4.w,
      child: BusInfoPopupWidget(
        busData: _selectedBus!,
        onClose: () {
          setState(() {
            _selectedBus = null;
          });
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    // Use the first bus as default route data
    final Map<String, dynamic> routeData = _busData.isNotEmpty ? _busData.first : {};

    return RouteBottomSheetWidget(
      routeData: routeData,
      onRefresh: _refreshTracking,
      onExpansionChanged: (isExpanded) {
        // Handle expansion state changes if needed
      },
    );
  }

  Widget _buildFloatingActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "center_location",
          onPressed: _centerMapOnUser,
          backgroundColor: AppTheme.accentTeal,
          child: CustomIconWidget(
            iconName: 'my_location',
            color: AppTheme.surfaceWhite,
            size: 24,
          ),
        ),
        SizedBox(height: 1.h),
        FloatingActionButton(
          heroTag: "toggle_tracking",
          onPressed: () {
            setState(() {
              _isTrackingEnabled = !_isTrackingEnabled;
            });
            HapticFeedback.lightImpact();
          },
          backgroundColor: _isTrackingEnabled
              ? AppTheme.warningAmber
              : AppTheme.successGreen,
          child: CustomIconWidget(
            iconName: _isTrackingEnabled ? 'pause' : 'play_arrow',
            color: AppTheme.surfaceWhite,
            size: 24,
          ),
        ),
      ],
    );
  }
}