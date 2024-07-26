import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final void Function()? onTap;
  final String buttonName;

  const AppButton({
    super.key,
    required this.buttonName,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ),
            )
        ),
      ),
    );
  }
}