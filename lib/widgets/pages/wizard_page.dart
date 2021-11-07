import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/wizards/advanced_item_wizard.dart';
import 'package:duszamobile2021/widgets/wizards/simple_item_wizard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WizardPage extends StatefulWidget {
  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {
  Account account;
  bool simple = true;

  _WizardPageState() : account = Modular.get<AccountRepository>().getAccount();

  createItem(Item item) {
    Account next = Account.copy(account);
    List<Item> nextItems = List.of(account.items);
    nextItems.add(item);
    next.items = nextItems;
    Modular.get<AccountRepository>().saveAccount(next);
    setState(() {
      account = next;
    });
    Modular.to.pop();
    Modular.to.navigate("/home");
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
            title: Text(S.of(context).new_title),
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
                child: simple
                    ? SimpleItemWizardWidget(
                        balances: account.balances,
                        createItem: createItem,
                      )
                    : AdvancedItemWizard(
                        account: account,
                        createItem: createItem,
                      )),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 18,
          child: ElevatedButton(
            child: Text(simple ? S.of(context).advanced : S.of(context).easy),
            onPressed: () {
              setState(() {
                simple = !simple;
              });
            },
          ),
        )
      ],
    );
  }
}
