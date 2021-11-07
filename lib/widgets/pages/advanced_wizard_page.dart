import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/wizards/simple_item_wizard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdvancedWizardPage extends StatefulWidget {
  @override
  State<AdvancedWizardPage> createState() => _AdvancedWizardPageState();
}

class _AdvancedWizardPageState extends State<AdvancedWizardPage> {
  Account account;

  bool isIncome = true;
  bool isSingle = true;
  int? balanceChipSelectedIndex;

  MoneyMaskedTextController amountTextEditingController =
      MoneyMaskedTextController(
          rightSymbol: " HUF",
          decimalSeparator: "",
          thousandSeparator: " ",
          precision: 0); //after
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();

  List<DropdownMenuItem> categories = [];

  String? selectedCategory;
  DateTime? selectedDateTime;

  int incomeToggleIndex = 0;
  int singleToggleIndex = 0;

  _AdvancedWizardPageState()
      : account = Modular.get<AccountRepository>().getAccount() {
    flattenCategories(account.categories).forEach((element) {
      categories.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    if (account.balances.length == 1) {
      balanceChipSelectedIndex = 0;
    }
  }

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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title:
                Text("${S.of(context).new_title} - ${S.of(context).advanced}"),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${S.of(context).balance}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: account.balances.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: ChoiceChip(
                              label: Text(account.balances[index].name),
                              selected: balanceChipSelectedIndex == index,
                              onSelected: (selected) {
                                setState(() {
                                  balanceChipSelectedIndex = index;
                                });
                              },
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(S.of(context).amount),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: S.of(context).specifyAmount),
                        controller: amountTextEditingController,
                        keyboardType: TextInputType.number),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                      initialLabelIndex: incomeToggleIndex,
                      totalSwitches: 2,
                      minWidth: 100,
                      labels: [
                        S.of(context).income,
                        S.of(context).outcome,
                      ],
                      onToggle: (index) {
                        setState(() {
                          incomeToggleIndex = index;
                          switch (index) {
                            case 0:
                              isIncome = true;
                              break;
                            case 1:
                              isIncome = false;
                              break;
                          }
                        });
                      },
                      animate: true,
                      animationDuration: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                      initialLabelIndex: singleToggleIndex,
                      totalSwitches: 2,
                      minWidth: 100,
                      labels: [
                        S.of(context).single,
                        S.of(context).monthly,
                      ],
                      onToggle: (index) {
                        setState(() {
                          singleToggleIndex = index;
                          switch (index) {
                            case 0:
                              isSingle = true;
                              break;
                            case 1:
                              isSingle = false;
                              break;
                          }
                        });
                      },
                      animate: true,
                      animationDuration: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(S.of(context).name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: S.of(context).addNameHere),
                      controller: nameTextEditingController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(S.of(context).category),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      onChanged: (dynamic selectedItem) {
                        selectedCategory = selectedItem;
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: S.of(context).chooseCategory),
                      items: categories,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(S.of(context).date),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: S.of(context).chooseDate),
                      controller: dateTextEditingController,
                      onTap: () async {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? pickedDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now());
                        if (pickedDateTime != null) {
                          dateTextEditingController.text =
                              pickedDateTime.toString();
                          setState(() {
                            selectedDateTime = pickedDateTime;
                          });
                        }
                      },
                    ),
                  ),
                  if (selectedCategory != null &&
                      balanceChipSelectedIndex != null &&
                      nameTextEditingController.text != "" &&
                      amountTextEditingController.text != "" &&
                      amountTextEditingController.numberValue != 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Item item = Item(
                                title: nameTextEditingController.text,
                                amount:
                                    amountTextEditingController.numberValue *
                                        (isIncome ? 1 : -1),
                                balance:
                                    account.balances[balanceChipSelectedIndex!],
                                category: selectedCategory!,
                                creation: selectedDateTime!,
                                monthly: !isSingle,
                              );
                              createItem(item);
                            },
                            child: Text(S.of(context).finishButton))
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 18,
          child: ElevatedButton(
            child: Text(S.of(context).easy),
            onPressed: () {
              Modular.to.pop();
              Modular.to.pushNamed("/wizard");
            },
          ),
        )
      ],
    );
  }
}
