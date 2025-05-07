import 'package:flutter/material.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.btnText,
    required this.onPressed,
    required this.width,
  });
  final String btnText;
  final void Function() onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? AppColors.greydarker300
                  : AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: title1Bold.copyWith(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                    ? AppColors.black
                    : AppColors.white,
          ),
        ),
      ),
    );
  }
}
