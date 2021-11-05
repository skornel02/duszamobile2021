


import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            child: Text("PÉNZ \$"),
          ),
          Text(S.of(context).latestTransactions),
          Container(
            height: 200,
            child: ListView(
              children: [
                Card(
                  child: Text("izé"),
                ),
              ],
            ),
          ),
          Text("Details"),

          Text(S.of(context).latestTransactions),
          Container(
            height: 200,
            child: ListView(
              children: [
                Card(
                  child: Text("izé"),
                ),
              ],
            ),
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
