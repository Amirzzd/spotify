import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final FontWeight? fontWeight;
  final double? height;

  const BasicAppButton({super.key,required this.onPressed,required this.title,this.height,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 80)
        ),
        child: Text(title,style: TextStyle(color: Colors.white,fontWeight: fontWeight),),
    );
  }
}
