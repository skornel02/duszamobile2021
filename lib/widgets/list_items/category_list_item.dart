import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryListItem extends StatelessWidget {
  String category;
  VoidCallback onPressedDeleteButton;

  CategoryListItem(
      {required this.category, required this.onPressedDeleteButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Text(category),
            const Spacer(),
            IconButton(
              onPressed: onPressedDeleteButton,
              icon: FaIcon(FontAwesomeIcons.trash),
            )
          ],
        ),
      ),
    );
  }
}
