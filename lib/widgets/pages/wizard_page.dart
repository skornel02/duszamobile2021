import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/wizards/simple_item_wizard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// useful video: https://www.youtube.com/watch?v=2aJZzRMziJc

class WizardPage extends StatefulWidget {
  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {
  Account account;

  _WizardPageState() : account = Modular.get<AccountRepository>().getAccount();

  createItem(Item item) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).new_title),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleItemWizardWidget(
              balances: account.balances,
              createItem: createItem,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 50),
              child: ElevatedButton(
                child: Text(S.of(context).advanced),
                onPressed: () {
                  setState(() {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
