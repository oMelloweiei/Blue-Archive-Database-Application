import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Text(
          text,
          maxLines: 2,
          softWrap: true,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
