import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class LoadingWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color valueColor;
  const LoadingWidget({Key? key, this.backgroundColor = greyColor, this.valueColor = Colors.blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: backgroundColor,
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        ),
      ),
    );
  }
}


