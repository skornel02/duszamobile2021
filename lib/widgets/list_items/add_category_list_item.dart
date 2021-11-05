import 'package:duszamobile2021/enums/money_type.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCategoryListItem extends StatelessWidget {


  AddCategoryListItem();


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(S.of(context).addNew),
          Spacer(),
          FaIcon(FontAwesomeIcons.plus),
        ],
      ),
    );
  }
}
