
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    this.onChanged,
    this.onSubitted,
    required this.label,
    this.suffixIcon,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.initialValue,
    this.inputFormatters,
    this.controller,
    this.autofocus = false,
    this.hintText = '',
    this.obscureText = false,
    this.isRequired = true,
    this.isEmail = false,
    this.isCI = false,
    this.isRUC = false,
    this.autocorrect= false,
    this.enableSuggestions= false,
    this.enabled= true,
    this.onTap,
    this.myFocusNode,
    this.validator,
    this.readOnly = false,
    this.textAlign,
    this.border,
    this.textSize,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.textColor,
  }) : super(key: key);

  final Function(String)? onChanged;
  final Function? onSubitted;
  final Function()? onTap;
  final String label;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;
  final TextEditingController? controller;
  final bool autofocus;
  final String hintText;
  final bool obscureText;
  final bool isRequired;
  final bool isEmail;
  final bool isCI;
  final bool isRUC;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool enabled;
  final FocusNode? myFocusNode;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final TextAlign? textAlign;
  final double? textSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(primaryColor: Colors.green),
      child: TextFormField(
        textCapitalization: textCapitalization,
        focusNode: myFocusNode,
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly,
        style: TextStyle(fontSize: textSize,color: textColor),
        textAlign: textAlign??TextAlign.start,
        onChanged: (value) => onChanged != null ? onChanged!(value) : () {},
        onFieldSubmitted: (value) => onSubitted != null ? onSubitted!() : () {},
        inputFormatters: inputFormatters,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        controller: controller,
        initialValue: initialValue,
        keyboardType: isEmail ? TextInputType.emailAddress : keyboardType,
        autofocus: autofocus,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        maxLines: maxLines??1,
        decoration: InputDecoration(
          border: border,
          hintText: hintText,
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: TextStyle(fontSize: textSize),
          fillColor: Colors.white,
          contentPadding: contentPadding ?? const EdgeInsets.only(top: 10.0, bottom: 10.0),
          counterText: '',

        ),
        validator: validator ??
            (value) {
              if (isRequired && (value == null || value.trim().isEmpty)) {
                return 'Campo obligatorio';
              }
              if (value == null || value.trim().isEmpty) {
                return null;
              }
              if (maxLength != null && value.length > maxLength!) {
                return '$maxLength caracteres máximo';
              }
              if (isCI) {
                return validateCI(value.trim());
              }
              if (isRUC) {
                return validateRUC(value);
              }
              return null;
            },
      ),
    );
  }
}

validateCI(String ci) {
  if (ci.isEmpty || ci.trim().length != 10) {
    return 'Cédula no valida';
  }

  var total = 0;

  for (var i = 0; i < ci.length - 1; i++) {
    var number = int.parse(ci[i]);
    if (i % 2 == 0) {
      var aux = number * 2;
      if (aux > 9) aux -= 9;
      total += aux;
    } else {
      total += number; // parseInt o concatenará en lugar de sumar
    }
  }

  total = total % 10 == 0 ? 0 : 10 - total % 10;

  if (int.parse(ci[ci.length - 1]) == total) {
    return null;
  } else {
    return 'Cédula no valida';
  }
}

validateRUC(String ruc) {
  if (ruc.isEmpty || ruc.trim().length != 13) {
    return 'RUC no válido';
  }

  if (validateCI(ruc.substring(0, 10)) != null) {
    return 'RUC no válido';
  }

  if (ruc.substring(10, 13) != '001') {
    return 'RUC no válido';
  }

  return null;
}
