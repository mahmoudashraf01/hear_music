import 'package:flutter/material.dart';
import 'package:hear_music/core/styles/color.dart';
import 'package:hear_music/core/styles/text.dart';
import 'package:hear_music/core/theme/theme_provider.dart';
import 'package:hear_music/core/widgets/music/nue_box.dart';
import 'package:provider/provider.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.inputFiledController,
    required this.hintTxt,
    required this.labelTxt,
    required this.validator,
  });
  final TextEditingController inputFiledController;
  final String hintTxt;
  final String labelTxt;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return NueBox(
      child: TextFormField(
        controller: inputFiledController,
        decoration: InputDecoration(
          labelText: labelTxt,
          hintText: hintTxt,
          labelStyle: title2.copyWith(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                    ? AppColors.white
                    : AppColors.black,
          ),
          hintStyle: title2Bold.copyWith(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                    ? AppColors.white
                    : AppColors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppColors.greydarker500),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: AppColors.greydarker500),
            gapPadding: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Colors.red),
            gapPadding: 10,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Colors.red),
            gapPadding: 10,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
