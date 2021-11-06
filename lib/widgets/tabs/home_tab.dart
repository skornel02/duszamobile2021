import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State {
  late Account account;

  _HomeTabState() {
    var repo = Modular.get<AccountRepository>();
    account = repo.getAccount();
    repo.addListener(() {
      setState(() {
        account = repo.getAccount();
      });
    });
  }

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
          if (account.balances.isEmpty) {
            Fluttertoast.showToast(
              msg: S.of(context).cantWithoutBalance,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.orange,
            );
            Modular.to.navigate("/balances");
            return;
          }
          Modular.to.pushNamed("/wizard");
        },
      ),
    );
  }
}
