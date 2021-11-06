import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:duszamobile2021/extensions.dart';
import 'package:expandable/expandable.dart';

// useful video: https://www.youtube.com/watch?v=2aJZzRMziJc

class WizardPage extends StatefulWidget {
  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {
  int wizardStep = 1;

  String? selectedTypeChip;
  String? selectedAmount;
  String? selectedAccountChip;

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

  int? accountChipSelectedIndex;

  List<String> accountChipOptions = [
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

  TextEditingController textEditingController = TextEditingController();


  ExpandableController controller1 = ExpandableController();
  ExpandableController controller2 = ExpandableController();
  ExpandableController controller3 = ExpandableController();

  ExpandableThemeData theme = const ExpandableThemeData(hasIcon: false, tapBodyToExpand: false, tapBodyToCollapse: false, tapHeaderToExpand: false);

  _WizardPageState(){
    controller1.toggle();
    textEditingController.addListener(() {
      setState(() {
        if(textEditingController.text != ""){
          amountIsFine = true;
        }else{
          amountIsFine = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).new_title),
        leading: IconButton(icon: const FaIcon(FontAwesomeIcons.arrowLeft), onPressed: (){
          Modular.to.pop();
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandablePanel(

              header: Row(
                children: [
                  Text("1"),
                  Text("${S.of(context).type}${selectedTypeChip != null ? ": ${selectedTypeChip}" : ""}"),
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
                        selectedTypeChip = typeChipOptions[typeChipSelectedIndex!];
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
                  Text("${S.of(context).account}${selectedAmount != null ? ": ${selectedAmount!.huf}" : ""}"),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    keyboardType: TextInputType.number
                  ),
                  ElevatedButton(
                    child: Text(S.of(context).continueButton),
                    onPressed: !amountIsFine ? null :  () {
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
                  Text("${S.of(context).type}${selectedAccountChip != null ? ": ${selectedAccountChip}" : ""}"),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: accountChipOptions.length,
                        itemBuilder: (context, index) {
                          return ChoiceChip(
                            label: Text(accountChipOptions[index]),
                            selected: accountChipSelectedIndex == index,
                            onSelected: (selected) {
                              setState(() {
                                accountChipSelectedIndex = index;
                              });
                            },
                          );
                        }),
                  ),
                  ElevatedButton(
                    child: Text(S.of(context).continueButton),
                    onPressed: accountChipSelectedIndex == null ? null : () {
                      setState(() {
                        controller3.toggle();
                        selectedAccountChip = accountChipOptions[accountChipSelectedIndex!];

                        wizardStep++;
                      });
                    },
                  )
                ],
              ),
              controller: controller3,
              theme: theme,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 50),
              child: ElevatedButton(
                child: Text(S.of(context).advanced),
                onPressed: () {
                  setState(() {
                    controller3.toggle();
                    selectedAccountChip = accountChipOptions[accountChipSelectedIndex!];

                    wizardStep++;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
