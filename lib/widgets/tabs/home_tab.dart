import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

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
            Container(
              height: 200,
              child: ListView(
                children: [
                  Card(
                    child: Text("izé", style: TextStyle(fontFamily: "Nunito", fontWeight: FontWeight.w700),),
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
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          Modular.to.pushNamed("/wizard");
        //  Modular.to.navigate("/wizard");
        },
      ),
    );
  }
}
