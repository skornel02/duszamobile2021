
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CategoriesTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
