
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiptsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(child: Text("Számla1"),),
            ],
          ),
          Card(
            child: Text("PÉNZ \$"),
          ),
          Text(S.of(context).latestTransactions),
          ListView(
            children: [
              Card(
                child: Text("izé"),
              ),
            ],
          ),
          Text("Details"),

          Text(S.of(context).latestTransactions),
          ListView(
            children: [
              Card(
                child: Text("izé"),
              ),
            ],
          ),


          Text(S.of(context).thisMonth),
          Row(
            children: [
              Card(
                child: Text("MÉG TÖBB PÉNZ"),
              ),
              Card(
                child: Text("MÉG TÖBB PÉNZ"),
              )
            ],
          ),

        ],
      ),
    );
  }
}
