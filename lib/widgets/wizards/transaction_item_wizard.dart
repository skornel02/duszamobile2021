import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:duszamobile2021/extensions.dart';
import 'package:lottie/lottie.dart';

class TransactionItemWizardWidget extends StatefulWidget {
  final List<Balance> balances;
  final Function(Item) createItem;

  const TransactionItemWizardWidget({
    Key? key,
    required this.balances,
    required this.createItem,
  }) : super(key: key);

  @override
  _TransactionItemWizardWidgetState createState() => _TransactionItemWizardWidgetState();
}

class _TransactionItemWizardWidgetState extends State<TransactionItemWizardWidget> {
  int wizardStep = 1;

  int selectedAmount = 0;

  bool amountIsFine = false;


  List<Balance> fromBalanceOptions = [];
  int? selectedFromBalanceIndex;
  List<Balance> toBalanceOptions = [];
  int? selectedToBalanceIndex;

  late MoneyMaskedTextController textEditingController;

  ExpandableController controller1 = ExpandableController();
  ExpandableController controller2 = ExpandableController();
  ExpandableController controller3 = ExpandableController();

  ExpandableThemeData theme = const ExpandableThemeData(
      hasIcon: false,
      tapBodyToExpand: false,
      tapBodyToCollapse: false,
      tapHeaderToExpand: false);


  Account account;

  _TransactionItemWizardWidgetState() : account = Modular.get<AccountRepository>().getAccount(){
    fromBalanceOptions = account.balances;
    toBalanceOptions = account.balances;
    controller1.toggle();
    textEditingController = MoneyMaskedTextController(
      rightSymbol: " HUF",
      decimalSeparator: "",
      thousandSeparator: " ",
      precision: 0,
    );
    textEditingController.addListener(() {
      setState(() {
        if (textEditingController.text != "" && textEditingController.numberValue != 0) {
          amountIsFine = true;
        } else {
          amountIsFine = false;
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 1
          ExpandablePanel(
            header: Row(
              children: [
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8.0, left: 12, right: 12),
                    child: Text("1"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${S.of(context).fromBalance}${selectedFromBalanceIndex != null ? ": ${fromBalanceOptions[selectedFromBalanceIndex!].name}" : ""}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            collapsed: Container(),
            expanded: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: fromBalanceOptions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: ChoiceChip(
                            elevation: 3,
                            backgroundColor: Colors.white,
                            label: Text(fromBalanceOptions[index].name),
                            selected: selectedFromBalanceIndex == index,
                            onSelected: (selected) {
                              setState(() {
                                selectedFromBalanceIndex = index;
                              });
                            },
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        child: Text(S.of(context).continueButton),
                        onPressed: selectedFromBalanceIndex == null
                            ? null
                            : () {
                          setState(() {
                            controller1.toggle();
                            controller2.toggle();
                          //  toBalanceOptions.removeAt(selectedFromBalanceChipIndex!);
                            wizardStep++;
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            controller: controller1,
            theme: theme,
          ),
          // 2
          ExpandablePanel(
            header: Row(
              children: [
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8.0, left: 12, right: 12),
                    child: Text("2"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${S.of(context).toBalance}${selectedToBalanceIndex != null ? ": ${toBalanceOptions[selectedToBalanceIndex!].name}" : ""}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            collapsed: Container(),
            expanded: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: toBalanceOptions.length,
                      itemBuilder: (context, index) {
                        if(selectedFromBalanceIndex == index){
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: ChoiceChip(
                            label: Text(toBalanceOptions[index].name),
                            selected: selectedToBalanceIndex == index,
                            onSelected: (selected) {
                              setState(() {
                                selectedToBalanceIndex = index;
                              });
                            },
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      child: Text(S.of(context).continueButton),
                      onPressed: selectedToBalanceIndex == null
                          ? null
                          : () {
                        setState(() {
                          controller2.toggle();
                          controller3.toggle();
                          wizardStep++;
                        });
                      },
                    )
                  ],
                ),
                selectedAmount != 0
                    ? Row(
                  children: [
                    Lottie.asset(
                      'assets/animations/falling_tree.json',
                      width: 200,
                      height: 200,
                    ),
                    Flexible(
                      child: Text(
                        S.of(context).amazonTrees +
                            "${(textEditingController.numberValue / 300).floor()}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
              ],
            ),
            controller: controller2,
            theme: theme,
          ),
          // 3
          ExpandablePanel(
            header: Row(
              children: [
                Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8.0, left: 12, right: 12),
                    child: Text("3"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${S.of(context).amount}${selectedAmount != 0 ? ": ${selectedAmount!.huf}" : ""}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            collapsed: Container(),
            expanded: Column(
              children: [
                TextField(
                    controller: textEditingController,
                    keyboardType: TextInputType.number),
                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, right: 8),
                      child: ElevatedButton(
                        child: Text(S.of(context).continueButton),
                        onPressed: !amountIsFine
                            ? null
                            : () {
                          setState(() {
                            controller3.toggle();
                            selectedAmount = textEditingController.numberValue.toInt();

                            wizardStep++;
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            controller: controller3,
            theme: theme,
          ),
          wizardStep == 4
              ? Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(S.of(context).finishButton),
                  onPressed: () {
                    Balance selectedFromBalance = fromBalanceOptions[selectedFromBalanceIndex!];
                    Balance selectedToBalance = toBalanceOptions[selectedToBalanceIndex!];

                    
                    Account next = Account.copy(account)..transfer(selectedFromBalance, selectedToBalance, selectedAmount);
                    Modular.get<AccountRepository>().saveAccount(next);
                    
                    Modular.to.pop();
                    Modular.to.navigate("/home");
                    /*
                    Item? item;
                    switch (typeChipSelectedIndex) {
                      case 0:
                        item = Item(
                          title: "Bevásárlás",
                          creation: DateTime.now(),
                          category: "Általános/Bevásárlás",
                          amount: (0 - amount).toDouble(),
                          balance: bal,
                        );
                        break;
                      case 1:
                        item = Item(
                          title: "Egyéb program",
                          creation: DateTime.now(),
                          category: "Program/Egyéb",
                          amount: (0 - amount).toDouble(),
                          balance: bal,
                        );
                        break;
                      case 2:
                        item = Item(
                          title: "Egyszeri bevétel",
                          creation: DateTime.now(),
                          category: "Bevétel/Egyszeri bevétel",
                          amount: (amount).toDouble(),
                          balance: bal,
                        );
                        break;
                      case 3:
                        item = Item(
                          title: "Ajándék",
                          creation: DateTime.now(),
                          category: "Bevétel/Ajándék",
                          amount: (amount).toDouble(),
                          balance: bal,
                        );
                        break;
                      case 4:
                        item = Item(
                          title: "Fizetés",
                          creation: DateTime.now(),
                          category: "Bevétel/Fizetés",
                          amount: (amount).toDouble(),
                          balance: bal,
                          monthly: true,
                        );
                        break;
                    }


                    if (item != null) {
                      widget.createItem(item);
                    }
                    */
                  },
                )
              ],
            ),
          )
              : const SizedBox(),
        ]),
      ],
    );
  }
}
