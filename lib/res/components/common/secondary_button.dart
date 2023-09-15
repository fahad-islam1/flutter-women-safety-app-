import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.onPress,
    required this.title,
  }) : super(key: key);
  final VoidCallback onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: TextButton(
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(
            // color: black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
