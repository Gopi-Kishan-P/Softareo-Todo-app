import 'package:flutter/material.dart';

class TodoAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "TO DO App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.wb_sunny_outlined),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
