import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/account_section_widget.dart';
import './widgets/help_section_widget.dart';
import './widgets/preferences_widget.dart';
import './widgets/profile_completion_widget.dart';
import './widgets/profile_form_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/security_settings_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  // Camera functionality
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  final ImagePicker _imagePicker = ImagePicker();

  // Form state
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;

  // User data
  Map<String, dynamic> _userData = {
    'nombre': 'María González',
    'email': 'maria.gonzalez@email.com',
    'telefono': '+593 99 123 4567',
    'fechaNacimiento': '15/03/1990',
    'profileImage':
        'https://images.unsplash.com/photo-1494790108755-2616b612b786?fm=jpg&q=60&w=400&ixlib=rb-4.0.3',
  };

  // Settings state
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;
  bool _darkModeEnabled = true;
  String _selectedLanguage = 'es';
  Map<String, bool> _notificationSettings = {
    'push': true,
    'email': false,
    'sms': false,
  };

  // Mock payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 1,
      'type': 'credit_card',
      'name': 'Visa **** 4532',
      'details': 'Vence 12/25',
    },
    {
      'id': 2,
      'type': 'account_balance_wallet',
      'name': 'PayPal',
      'details': 'maria.gonzalez@email.com',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 4, vsync: this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      if (!kIsWeb) {
        final hasPermission = await _requestCameraPermission();
        if (!hasPermission) return;
      }

      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final camera = kIsWeb
            ? _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.front,
                orElse: () => _cameras.first)
            : _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.back,
                orElse: () => _cameras.first);

        _cameraController = CameraController(
          camera,
          kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
        );

        await _cameraController!.initialize();
        await _applySettings();
      }
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
      if (!kIsWeb) {
        await _cameraController!.setFlashMode(FlashMode.auto);
      }
    } catch (e) {
      debugPrint('Error applying camera settings: $e');
    }
  }

  Future<void> _capturePhoto() async {
    try {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        final XFile photo = await _cameraController!.takePicture();
        setState(() {
          _userData['profileImage'] = photo.path;
          _hasUnsavedChanges = true;
        });
        _showToast('Foto capturada exitosamente');
      } else {
        await _selectFromGallery();
      }
    } catch (e) {
      await _selectFromGallery();
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _userData['profileImage'] = image.path;
          _hasUnsavedChanges = true;
        });
        _showToast('Imagen seleccionada exitosamente');
      }
    } catch (e) {
      _showToast('Error al seleccionar imagen');
    }
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Actualizar Foto de Perfil',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            _buildCameraOption(
              icon: 'camera_alt',
              title: 'Tomar Foto',
              onTap: () {
                Navigator.pop(context);
                _capturePhoto();
              },
            ),
            SizedBox(height: 2.h),
            _buildCameraOption(
              icon: 'photo_library',
              title: 'Seleccionar de Galería',
              onTap: () {
                Navigator.pop(context);
                _selectFromGallery();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.primaryNavy,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderSubtle),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.accentTeal,
              size: 6.w,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.surfaceWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFormDataChanged(Map<String, dynamic> newData) {
    setState(() {
      _userData.addAll(newData);
      _hasUnsavedChanges = true;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _hasUnsavedChanges = false;
        _isLoading = false;
      });

      _showToast('Cambios guardados exitosamente');
    } catch (e) {
      setState(() => _isLoading = false);
      _showToast('Error al guardar cambios');
    }
  }

  void _addPaymentMethod() {
    _showToast('Funcionalidad de agregar método de pago próximamente');
  }

  void _changePassword() {
    _showToast('Funcionalidad de cambio de contraseña próximamente');
  }

  void _onBiometricChanged(bool value) {
    setState(() => _biometricEnabled = value);
    _showToast(value
        ? 'Autenticación biométrica activada'
        : 'Autenticación biométrica desactivada');
  }

  void _onTwoFactorChanged(bool value) {
    setState(() => _twoFactorEnabled = value);
    _showToast(
        value ? 'Autenticación 2FA activada' : 'Autenticación 2FA desactivada');
  }

  void _onDarkModeChanged(bool value) {
    setState(() => _darkModeEnabled = value);
    _showToast(value ? 'Modo oscuro activado' : 'Modo claro activado');
  }

  void _onLanguageChanged(String language) {
    setState(() => _selectedLanguage = language);
    _showToast(language == 'es'
        ? 'Idioma cambiado a Español'
        : 'Language changed to English');
  }

  void _onNotificationChanged(String type, bool value) {
    setState(() => _notificationSettings[type] = value);
    _showToast('Configuración de notificaciones actualizada');
  }

  void _onFaqPressed() {
    _showToast('Abriendo preguntas frecuentes');
  }

  void _onContactPressed() {
    _showToast('Contactando soporte técnico');
  }

  void _onTutorialPressed() {
    _showToast('Reproduciendo videos tutoriales');
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.backgroundSecondary,
        title: Text(
          'Cerrar Sesión',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.surfaceWhite,
          ),
        ),
        content: Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.neutralGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: AppTheme.neutralGray),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login-screen', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
            ),
            child: Text(
              'Cerrar Sesión',
              style: TextStyle(color: AppTheme.surfaceWhite),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateCompletionPercentage() {
    int completedFields = 0;
    int totalFields = 4;

    if (_userData['nombre']?.isNotEmpty == true) completedFields++;
    if (_userData['email']?.isNotEmpty == true) completedFields++;
    if (_userData['telefono']?.isNotEmpty == true) completedFields++;
    if (_userData['fechaNacimiento']?.isNotEmpty == true) completedFields++;

    return (completedFields / totalFields) * 100;
  }

  List<String> _getMissingFields() {
    List<String> missing = [];

    if (_userData['nombre']?.isEmpty != false) missing.add('Nombre');
    if (_userData['email']?.isEmpty != false) missing.add('Email');
    if (_userData['telefono']?.isEmpty != false) missing.add('Teléfono');
    if (_userData['fechaNacimiento']?.isEmpty != false)
      missing.add('Fecha de Nacimiento');

    return missing;
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.backgroundSecondary,
      textColor: AppTheme.surfaceWhite,
    );
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppTheme.backgroundSecondary,
          title: Text(
            'Cambios sin Guardar',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
            ),
          ),
          content: Text(
            '¿Deseas guardar los cambios antes de salir?',
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.neutralGray,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Descartar',
                style: TextStyle(color: AppTheme.errorRed),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context, true);
                await _saveChanges();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      );
      return result ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.primaryNavy,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryNavy,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.pop(context);
              }
            },
            icon: CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.surfaceWhite,
              size: 6.w,
            ),
          ),
          title: Text(
            'Mi Perfil',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Perfil'),
              Tab(text: 'Cuenta'),
              Tab(text: 'Configuración'),
              Tab(text: 'Ayuda'),
            ],
            labelColor: AppTheme.accentTeal,
            unselectedLabelColor: AppTheme.neutralGray,
            indicatorColor: AppTheme.accentTeal,
            labelStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle:
                AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          children: [
            ProfileCompletionWidget(
              completionPercentage: _calculateCompletionPercentage(),
              missingFields: _getMissingFields(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Profile Tab
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        ProfileHeaderWidget(
                          profileImageUrl: _userData['profileImage'] ?? '',
                          onCameraPressed: _showCameraOptions,
                        ),
                        ProfileFormWidget(
                          userData: _userData,
                          onDataChanged: _onFormDataChanged,
                          isLoading: _isLoading,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  // Account Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        AccountSectionWidget(
                          paymentMethods: _paymentMethods,
                          onAddPaymentMethod: _addPaymentMethod,
                        ),
                        SecuritySettingsWidget(
                          biometricEnabled: _biometricEnabled,
                          twoFactorEnabled: _twoFactorEnabled,
                          onBiometricChanged: _onBiometricChanged,
                          onTwoFactorChanged: _onTwoFactorChanged,
                          onChangePassword: _changePassword,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  // Settings Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        PreferencesWidget(
                          darkModeEnabled: _darkModeEnabled,
                          selectedLanguage: _selectedLanguage,
                          notificationSettings: _notificationSettings,
                          onDarkModeChanged: _onDarkModeChanged,
                          onLanguageChanged: _onLanguageChanged,
                          onNotificationChanged: _onNotificationChanged,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  // Help Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        HelpSectionWidget(
                          onFaqPressed: _onFaqPressed,
                          onContactPressed: _onContactPressed,
                          onTutorialPressed: _onTutorialPressed,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.errorRed,
                              foregroundColor: AppTheme.surfaceWhite,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconWidget(
                                  iconName: 'logout',
                                  color: AppTheme.surfaceWhite,
                                  size: 5.w,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  'Cerrar Sesión',
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.surfaceWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }
}
