import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:duszamobile2021/extensions.dart';

class SimpleItemWizardWidget extends StatefulWidget {
  final List<Balance> balances;

  const SimpleItemWizardWidget({Key? key, required this.balances})
      : super(key: key);

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
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
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
                //TODO: Create item;
              },
            )
          : const SizedBox(),
    ]);
  }
}
