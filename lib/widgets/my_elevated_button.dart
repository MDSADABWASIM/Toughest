import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final Color? disabledColor;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? hoverColor;
  final Color? splashColor;
  final double? elevation;
  final double? disabledElevation;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;

  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.disabledColor,
    this.textColor,
    this.disabledTextColor,
    this.hoverColor,
    this.splashColor,
    this.elevation,
    this.disabledElevation,
    this.padding,
    this.shape,
  });

  bool _isPressed(Set<WidgetState> states) =>
      states.contains(WidgetState.pressed);
  bool _isDisabled(Set<WidgetState> states) =>
      states.contains(WidgetState.disabled);
  bool _isHovered(Set<WidgetState> states) =>
      states.contains(WidgetState.hovered);

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (_isDisabled(states)) {
          return disabledColor;
        } else if (_isHovered(states)) {
          return hoverColor;
        }
        return color;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (_isDisabled(states)) {
          return disabledTextColor;
        } else {
          return null;
        }
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (_isPressed(states)) {
          return splashColor;
        } else {
          return null;
        }
      }),
      elevation: WidgetStateProperty.resolveWith<double?>((states) {
        if (_isDisabled(states)) return disabledElevation;
        return elevation;
      }),
      shape: WidgetStateProperty.all<OutlinedBorder?>(shape),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(padding),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
