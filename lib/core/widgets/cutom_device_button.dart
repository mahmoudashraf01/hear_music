import 'package:flutter/material.dart';

class CustomDeviceButton extends StatelessWidget {
  const CustomDeviceButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: StarBorder(side: BorderSide.none)),
      onPressed: onPressed,
      child: child,
    );
  }
}
