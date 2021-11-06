import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/widgets/balances/balance_information.dart';
import 'package:duszamobile2021/widgets/balances/balance_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceTab extends StatefulWidget {
  @override
  State<BalanceTab> createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {
  int? balanceChipSelectedIndex;
  Account account;

  _BalanceTabState() : account = Modular.get<AccountRepository>().getAccount();

  handleSelectBalance(int index) {
    setState(() {
      balanceChipSelectedIndex = index;
    });
  }

  createBalance(Balance balance) {
    Account next = Account.copy(account);
    next.balances.add(balance);
    Modular.get<AccountRepository>().saveAccount(next);
    setState(() {
      account = next;
    });
    Fluttertoast.showToast(
      msg: S.current.balanceCreated,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            BalancePicker(
              balances: account.balances,
              selectIndex: handleSelectBalance,
              handleCreate: createBalance,
              selectedIndex: balanceChipSelectedIndex,
            ),
            balanceChipSelectedIndex != null
                ? BalanceInformation(
                    account: account,
                    balance: account.balances[balanceChipSelectedIndex!],
                  )
                : Text("_SELECT_BALANCE"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(
          FontAwesomeIcons.dollarSign,
          color: Theme.of(context).disabledColor,
        ),
        onPressed: null,
      ),
    );
  }
}
