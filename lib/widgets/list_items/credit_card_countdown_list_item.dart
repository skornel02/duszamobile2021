import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditCardCountdownListItem extends StatelessWidget {

  String card;
  DateTime date;
  DateTime countdownDate;

  CreditCardCountdownListItem(this.card, this.date, this.countdownDate);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              Text(card),
              Text("$date.toString()")
            ],
          ),),
          Text("Ezt majd...")
        ],
      ),
    );
  }
}
