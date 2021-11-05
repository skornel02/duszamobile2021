
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../drawer.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      drawer: drawer(context),
      body: Center(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const FaIcon(FontAwesomeIcons.home)),
          BottomNavigationBarItem(icon: const FaIcon(FontAwesomeIcons.home)),
          BottomNavigationBarItem(icon: const FaIcon(FontAwesomeIcons.home)),
          BottomNavigationBarItem(icon: const FaIcon(FontAwesomeIcons.home)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
