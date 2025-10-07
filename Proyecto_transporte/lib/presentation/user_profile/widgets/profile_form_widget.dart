import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileFormWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Function(Map<String, dynamic>) onDataChanged;
  final bool isLoading;

  const ProfileFormWidget({
    Key? key,
    required this.userData,
    required this.onDataChanged,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  late TextEditingController _nombreController;
  late TextEditingController _emailController;
  late TextEditingController _telefonoController;
  late TextEditingController _fechaNacimientoController;

  Map<String, dynamic> _formData = {};
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _formData = Map.from(widget.userData);
    _nombreController = TextEditingController(text: _formData['nombre'] ?? '');
    _emailController = TextEditingController(text: _formData['email'] ?? '');
    _telefonoController =
        TextEditingController(text: _formData['telefono'] ?? '');
    _fechaNacimientoController =
        TextEditingController(text: _formData['fechaNacimiento'] ?? '');

    _nombreController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _telefonoController.addListener(_onFieldChanged);
    _fechaNacimientoController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    final newData = {
      'nombre': _nombreController.text,
      'email': _emailController.text,
      'telefono': _telefonoController.text,
      'fechaNacimiento': _fechaNacimientoController.text,
    };

    final hasChanges = newData['nombre'] != widget.userData['nombre'] ||
        newData['email'] != widget.userData['email'] ||
        newData['telefono'] != widget.userData['telefono'] ||
        newData['fechaNacimiento'] != widget.userData['fechaNacimiento'];

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
        _formData = newData;
      });
      widget.onDataChanged(_formData);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Ingrese un email válido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value.replaceAll(' ', ''))) {
      return 'Ingrese un teléfono válido';
    }
    return null;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: AppTheme.darkTheme,
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      _fechaNacimientoController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información Personal',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildTextField(
            controller: _nombreController,
            label: 'Nombre Completo',
            icon: 'person',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _emailController,
            label: 'Correo Electrónico',
            icon: 'email',
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _telefonoController,
            label: 'Teléfono',
            icon: 'phone',
            keyboardType: TextInputType.phone,
            validator: _validatePhone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s]')),
            ],
          ),
          SizedBox(height: 2.h),
          _buildTextField(
            controller: _fechaNacimientoController,
            label: 'Fecha de Nacimiento',
            icon: 'calendar_today',
            readOnly: true,
            onTap: _selectDate,
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: _hasChanges && !widget.isLoading
                  ? () => widget.onDataChanged(_formData)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _hasChanges ? AppTheme.accentTeal : AppTheme.neutralGray,
                foregroundColor: AppTheme.surfaceWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        color: AppTheme.surfaceWhite,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Guardar Cambios',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String icon,
    TextInputType? keyboardType,
    TextCapitalization? textCapitalization,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      onTap: onTap,
      style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
        color: AppTheme.surfaceWhite,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            AppTheme.darkTheme.inputDecorationTheme.labelStyle?.copyWith(
          color: AppTheme.neutralGray,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(3.w),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.accentTeal,
            size: 5.w,
          ),
        ),
        filled: true,
        fillColor: AppTheme.backgroundSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.accentTeal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.errorRed),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      ),
      validator: validator,
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }
}
