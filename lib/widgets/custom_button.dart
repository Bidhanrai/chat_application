import 'package:flutter/material.dart';
import 'loading_widget.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool isBusy;
  const CustomButton({super.key, required this.label, this.onPressed, this.isBusy = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      child: isBusy
          ? const LoadingWidget()
          : Text(label),
    );
  }
}
