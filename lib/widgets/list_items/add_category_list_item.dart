import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCategoryListItem extends StatelessWidget {
  String text;
  VoidCallback onAddButtonPressed;

  bool noCard;
  bool noSpacer;

  AddCategoryListItem(
      {required this.text,
      required this.onAddButtonPressed,
      this.noCard = false,
      this.noSpacer = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddButtonPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Text(S.of(context).addNew),
              if (!noSpacer) const Spacer(),
              IconButton(
                onPressed: onAddButtonPressed,
                icon: const FaIcon(FontAwesomeIcons.plus),
              )
            ],
          ),
        ),
      ),
    );
  }
}
