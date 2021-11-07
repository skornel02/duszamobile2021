import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/widgets/balances/balance_information.dart';
import 'package:duszamobile2021/widgets/balances/balance_picker.dart';
import 'package:flutter/cupertino.dart';
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
  late AccountRepository repo;
  late Account account;
  late VoidCallback listener;

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
                child: BalancePicker(
                  balances: account.balances,
                  selectIndex: handleSelectBalance,
                  handleCreate: createBalance,
                  selectedIndex: balanceChipSelectedIndex,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: viewportConstraints.maxHeight - 80),
                child: balanceChipSelectedIndex != null
                    ? SingleChildScrollView(
                        child: BalanceInformation(
                          account: account,
                          balance: account.balances[balanceChipSelectedIndex!],
                        ),
                      )
                    : Align(
                        child: Text(
                          S.of(context).selectBalance,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        alignment: Alignment.center,
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(
          FontAwesomeIcons.dollarSign,
         // color: Theme.of(context).disabledColor,
        ),
        onPressed:  (){
          if(account.balances.length >= 2){
            Modular.to.pushNamed("/transaction-wizard");
          }
        },
      ),
    );
  }
}
