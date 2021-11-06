import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:duszamobile2021/extensions.dart';

class SimpleItemWizardWidget extends StatefulWidget {
  final List<Balance> balances;
  final Function(Item) createItem;

  const SimpleItemWizardWidget({
    Key? key,
    required this.balances,
    required this.createItem,
  }) : super(key: key);

  @override
  _SimpleItemWizardWidgetState createState() => _SimpleItemWizardWidgetState();
}

class _SimpleItemWizardWidgetState extends State<SimpleItemWizardWidget> {
  int wizardStep = 1;

  String? selectedTypeChip;
  String? selectedAmount;
  Balance? selectedBalance;

  bool amountIsFine = false;

  int? typeChipSelectedIndex;

  List<String> typeChipOptions = [
    'Bevásárlás',
    'Egyéb program',
    'Egyszeri bevétel',
    'Ajándék pénz',
    'Rendszeres fizetés',
  ];

  int? balanceChipSelectedIndex;

  TextEditingController textEditingController = TextEditingController();

  ExpandableController controller1 = ExpandableController();
  ExpandableController controller2 = ExpandableController();
  ExpandableController controller3 = ExpandableController();

  ExpandableThemeData theme = const ExpandableThemeData(
      hasIcon: false,
      tapBodyToExpand: false,
      tapBodyToCollapse: false,
      tapHeaderToExpand: false);

  _SimpleItemWizardWidgetState() {
    controller1.toggle();
    textEditingController.addListener(() {
      setState(() {
        if (textEditingController.text != "") {
          amountIsFine = true;
        } else {
          amountIsFine = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ExpandablePanel(
        header: Row(
          children: [
            Text("1"),
            Text(
                "${S.of(context).type}${selectedTypeChip != null ? ": ${selectedTypeChip}" : ""}"),
          ],
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: typeChipOptions.length,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      elevation: 3,
                      backgroundColor: Colors.white,
                      label: Text(typeChipOptions[index]),
                      selected: typeChipSelectedIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          typeChipSelectedIndex = index;
                        });
                      },
                    );
                  }),
            ),
            ElevatedButton(
              child: Text(S.of(context).continueButton),
              onPressed: typeChipSelectedIndex == null
                  ? null
                  : () {
                      setState(() {
                        controller1.toggle();
                        controller2.toggle();
                        selectedTypeChip =
                            typeChipOptions[typeChipSelectedIndex!];
                        wizardStep++;
                      });
                    },
            )
          ],
        ),
        controller: controller1,
        theme: theme,
      ),
      ExpandablePanel(
        header: Row(
          children: [
            Text("2"),
            Text(
                "${S.of(context).account}${selectedAmount != null ? ": ${selectedAmount!.huf}" : ""}"),
          ],
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            TextField(
                controller: textEditingController,
                keyboardType: TextInputType.number),
            ElevatedButton(
              child: Text(S.of(context).continueButton),
              onPressed: !amountIsFine
                  ? null
                  : () {
                      setState(() {
                        controller2.toggle();
                        controller3.toggle();
                        selectedAmount = textEditingController.text;

                        wizardStep++;
                      });
                    },
            )
          ],
        ),
        controller: controller2,
        theme: theme,
      ),
      ExpandablePanel(
        header: Row(
          children: [
            Text("3"),
            Text(
                "${S.of(context).type}${selectedBalance != null ? ": ${selectedBalance}" : ""}"),
          ],
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.balances.length,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      label: Text(widget.balances[index].name),
                      selected: balanceChipSelectedIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          balanceChipSelectedIndex = index;
                        });
                      },
                    );
                  }),
            ),
            ElevatedButton(
              child: Text(S.of(context).continueButton),
              onPressed: balanceChipSelectedIndex == null
                  ? null
                  : () {
                      setState(() {
                        controller3.toggle();
                        selectedBalance =
                            widget.balances[balanceChipSelectedIndex!];

                        wizardStep++;
                      });
                    },
            )
          ],
        ),
        controller: controller3,
        theme: theme,
      ),
      wizardStep == 4
          ? ElevatedButton(
              child: Text(S.of(context).finishButton),
              onPressed: () {
                String type = typeChipOptions[typeChipSelectedIndex!];
                int amount = int.parse(selectedAmount!);
                Balance bal = selectedBalance!;
                print("${type} preset: ${amount} HUF to: ${bal.name}");

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
              },
            )
          : const SizedBox(),
    ]);
  }
}
