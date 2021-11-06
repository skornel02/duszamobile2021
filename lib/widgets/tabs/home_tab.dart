import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  Account account;

  HomeTab({Key? key})
      : account = Modular.get<AccountRepository>().getAccount(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Text(
                  "PÉNZ: ${account.getRunningBalance(DateTime.now())} HUF"),
            ),
            Card(
              child: Text(
                  "KIADÁS HÓNAP: ${account.getSpendingMonth(DateTime.now().year, DateTime.now().month)} HUF"),
            ),
            Card(
              child: Text(
                  "BEVÉTEL HÓNAP: ${account.getIncomeMonth(DateTime.now().year, DateTime.now().month)} HUF"),
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
