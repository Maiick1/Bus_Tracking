import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/qr_ticket_display/qr_ticket_display.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/user_profile/user_profile.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/real_time_bus_tracking/real_time_bus_tracking.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String qrTicketDisplay = '/qr-ticket-display';
  static const String homeDashboard = '/home-dashboard';
  static const String userProfile = '/user-profile';
  static const String login = '/login-screen';
  static const String realTimeBusTracking = '/real-time-bus-tracking';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    qrTicketDisplay: (context) => const QrTicketDisplay(),
    homeDashboard: (context) => const HomeDashboard(),
    userProfile: (context) => const UserProfile(),
    login: (context) => const LoginScreen(),
    realTimeBusTracking: (context) => const RealTimeBusTracking(),
    // TODO: Add your other routes here
  };
}
