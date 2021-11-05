import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryListItem extends StatelessWidget {

  String category;

  CategoryListItem(this.category);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(category),
          Spacer(),
          FaIcon(FontAwesomeIcons.trash),
        ],
      ),
    );
  }
}
