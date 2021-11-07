import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/wizards/simple_item_wizard.dart';
import 'package:duszamobile2021/widgets/wizards/transaction_item_wizard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionWizardPage extends StatefulWidget {
  @override
  State<TransactionWizardPage> createState() => _TransactionWizardPageState();
}

class _TransactionWizardPageState extends State<TransactionWizardPage> {
  Account account;

  _TransactionWizardPageState() : account = Modular.get<AccountRepository>().getAccount();

  createTransaction(Item item) {
    Account next = Account.copy(account);
    next.items.add(item);
    Modular.get<AccountRepository>().saveAccount(next);
    setState(() {
      account = next;
    });
    Modular.to.pop();
    Fluttertoast.showToast(
      msg: S.current.itemCreated,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).newTransaction),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionItemWizardWidget(
                    balances: account.balances,
                    createItem: createTransaction,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
