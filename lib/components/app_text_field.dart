import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData leadingIcon;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(leadingIcon, color: Colors.grey), // Add this line
        ),
      ),
    );
  }
}