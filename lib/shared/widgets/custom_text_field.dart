import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';
import '../../core/utils/responsive_layout.dart';
enum TextFieldType {
  email,
  password,
  confirmPassword,
  phoneNumber,
  name,
  otp,
  address
}
class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextFieldType type;
  final Color? fillColor;
  final bool isLabelRequired;
  final bool isFilled;
  final double width;

  CustomTextFormField({
    super.key,
    required this.type,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    bool? obscureText,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.border,
    this.contentPadding,
    this.textStyle,
    this.fillColor,
    this.isFilled = true,
    this.isLabelRequired = false,
    this.width = 58
  }) : obscureText = obscureText ?? type.isObscure;

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {

    // OTP SPECIAL UI
    if (widget.type == TextFieldType.otp) {
      return _buildOtpField(context);
    }

    return SizedBox(
      height: widget.width,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator ?? widget.type.validator,
        obscureText: _isObscured,
        keyboardType: widget.keyboardType ?? widget.type.keyboardType,
        maxLines: widget.maxLines ?? widget.type.maxLines,
        maxLength: widget.type.maxLength,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        style: widget.textStyle ??
            TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryFontColor,
            ),
        decoration: _decoration(context),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------------------------

  InputDecoration _decoration(BuildContext context) {
    final radius = 24.0;

    return InputDecoration(
      hintText: widget.hintText ?? widget.type.hint,
      labelText:(widget.isLabelRequired)? widget.labelText ?? widget.type.label : null ,
      filled: widget.isFilled,
      fillColor: widget.fillColor ?? AppColors.placeholderColor.withValues(alpha: 0.4),
      hintStyle: TextStyle(
        fontSize: 14,
        color: AppColors.secondaryFontColor.withValues(alpha: 0.7),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: AppColors.secondaryFontColor,
      ),
      prefixIcon: _wrapIcon(widget.prefixIcon),
      suffixIcon: _buildSuffixIcon(),

      contentPadding: widget.contentPadding ,

      border: widget.border ?? _outlineBorder(radius,   AppColors.primaryColor,),
      enabledBorder:
          widget.border ?? _outlineBorder(
              radius,
              Colors.transparent
          ),
      disabledBorder:  _outlineBorder(
        radius,
        Colors.transparent
      ),
      focusedBorder: widget.border ??
          _outlineBorder(
            radius,
            AppColors.primaryColor,
            width:0.2,
          ),
      errorBorder:
          _outlineBorder(radius, Colors.red, width:0.2),
      focusedErrorBorder:
          _outlineBorder(radius, Colors.red, width: 0.2),
    );
  }

  // ---------------------------------------------------------------------------
  // SUFFIX ICON LOGIC (PASSWORD TOGGLE)
  // ---------------------------------------------------------------------------

  Widget? _buildSuffixIcon() {

    if (widget.suffixIcon != null) {
      return _wrapIcon(widget.suffixIcon);
    }

    if (!widget.type.isObscure) return null;

    return IconButton(
      icon: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility,
        size: 20,
        color: AppColors.secondaryFontColor,
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------

  OutlineInputBorder _outlineBorder(
    double radius,
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget _buildOtpField(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 6,
      validator: widget.validator ?? widget.type.validator,
      style: TextStyle(
        fontSize: 20,
        letterSpacing: 12,
        fontWeight: FontWeight.bold,
      ),
      decoration: _decoration(context).copyWith(
        counterText: "",
        hintText: "------",
      ),
    );
  }

  Widget? _wrapIcon(Widget? icon) {
    if (icon != null) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: icon,
      );
    }

    IconData data = switch (widget.type) {
      TextFieldType.email => Icons.email,
      TextFieldType.password => Icons.lock,
      TextFieldType.phoneNumber => Icons.call,
      TextFieldType.name => Icons.person,
      TextFieldType.otp => Icons.verified,
      TextFieldType.address => Icons.home,
      TextFieldType.confirmPassword => Icons.lock,
    };

    return Icon(data, color: AppColors.secondaryFontColor);
  }
}

extension TextFieldTypeX on TextFieldType {

  String get label {
    switch (this) {
      case TextFieldType.email:
        return "Email";
      case TextFieldType.password:
        return "Password";
      case TextFieldType.phoneNumber:
        return "Mobile Number";
      case TextFieldType.name:
        return "Name";
      case TextFieldType.otp:
        return "OTP";
      case TextFieldType.address:
        return "Address";
      case TextFieldType.confirmPassword:
        return "Confirm Password";
    }
  }

  String get hint {
    switch (this) {
      case TextFieldType.email:
        return "Enter email";
      case TextFieldType.password:
        return "Enter password";
      case TextFieldType.phoneNumber:
        return "Enter mobile number";
      case TextFieldType.name:
        return "Enter name";
      case TextFieldType.otp:
        return "------";
      case TextFieldType.address:
         return "Enter Address";
      case TextFieldType.confirmPassword:
        return "Enter Confirm password";
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phoneNumber:
      case TextFieldType.otp:
        return TextInputType.number;
      case TextFieldType.name:
        return TextInputType.name;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.address:
        return TextInputType.text;
      case TextFieldType.confirmPassword:
        return TextInputType.visiblePassword;
    }
  }

  bool get isObscure => this == TextFieldType.password;

  int get maxLines => this == TextFieldType.otp ? 1 : 1;

  int? get maxLength => this == TextFieldType.otp ? 6 : null;

  String? Function(String?) get validator {
    switch (this) {
      case TextFieldType.email:
        return (v) {
          if (v == null || v.isEmpty) return "Email is required";
          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(v)) {
            return "Invalid email";
          }
          return null;
        };

      case TextFieldType.password:
        return (v) {
          if (v == null || v.length < 6) {
            return "Password must be 6+ characters";
          }
          return null;
        };

      case TextFieldType.phoneNumber:
        return (v) {
          if (v == null || v.length != 10) {
            return "Enter valid 10 digit number";
          }
          return null;
        };

      case TextFieldType.name:
        return (v) {
          if (v == null || v.trim().isEmpty) {
            return "Name is required";
          }
          return null;
        };

      case TextFieldType.otp:
        return (v) {
          if (v == null || v.length != 6) {
            return "Enter valid OTP";
          }
          return null;
        };
      case TextFieldType.address:
        return (v) {
          if (v == null || v.trim().isEmpty) {
            return "Address is required";
          }
          return null;
        };
      case TextFieldType.confirmPassword:
        return (v) {
          if (v == null || v.length < 6) {
            return "Password must be 6+ characters";
          }
          return null;
        };
    }
  }
}




