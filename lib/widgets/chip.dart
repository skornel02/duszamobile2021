import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chip extends StatelessWidget {
  String text;
  String? label;

  Chip({required this.text, this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          if (label != null)
            Text(
              label!,
              style: TextStyle(color: Colors.black26, fontSize: 12),
            ),
          Text(text),
        ],
      ),
    );
  }
}
