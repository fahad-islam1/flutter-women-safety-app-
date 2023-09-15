// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:women_safety_app/res/utils/qoutes.dart';

class CustomAppbar extends StatelessWidget {
  final int index;
  final onTap;
  const CustomAppbar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          sweetSayings[index],
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
