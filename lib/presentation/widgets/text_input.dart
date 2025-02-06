import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/presentation/colors/color.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.hint});

  final TextEditingController controller;
  final bool isPassword;
  final String hint;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isRevieled = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? isRevieled : false,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isRevieled = !isRevieled;
                  });
                },
                icon: SvgPicture.asset(
                    '/Users/uksivt/Desktop/test2/test2/assets/Eye.svg'),
              )
            : null,
        hintStyle: TextStyle(
            fontFamily: 'New Peninim MT',
            fontSize: 14,
            color: MyColors.hintColor),
        hintText: widget.hint,
        filled: true,
        fillColor: MyColors.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
