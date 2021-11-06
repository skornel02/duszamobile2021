import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable/expandable.dart';

// useful video: https://www.youtube.com/watch?v=2aJZzRMziJc

class WizardPage extends StatefulWidget {
  @override
  State<WizardPage> createState() => _WizardPageState();
}

class _WizardPageState extends State<WizardPage> {
  int wizardStep = 1;

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


  _WizardPageState(){
    controller1.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).new_title),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            ExpandablePanel(

              header: Row(
                children: [
                  Text("1"),
                  Text("Type"),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: 200,
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
                    child: typeChipSelectedIndex == null
                        ? null
                        : Text(S.of(context).continueButton),
                    onPressed: () {
                      setState(() {
                        controller1.toggle();
                        controller2.toggle();
                        wizardStep++;
                      });
                    },
                  )
                ],
              ),
              controller: controller1,
              theme: const ExpandableThemeData(hasIcon: false),
            ),
            ExpandablePanel(
              header: Row(
                children: [
                  Text("2"),
                  Text("Type"),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                  ),
                  ElevatedButton(
                    child: Text(S.of(context).continueButton),
                    onPressed: () {
                      setState(() {
                        controller2.toggle();
                        controller3.toggle();
                        wizardStep++;
                      });
                    },
                  )
                ],
              ),
              controller: controller2,
              theme: const ExpandableThemeData(hasIcon: false),
            ),
            ExpandablePanel(
              header: Row(
                children: [
                  Text("3"),
                  Text("Type"),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: 200,
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
                    onPressed: () {
                      setState(() {
                        controller3.toggle();
                        wizardStep++;
                      });
                    },
                  )
                ],
              ),
              controller: controller3,
              theme: const ExpandableThemeData(hasIcon: false),
            ),
            /*
            ExpansionPanel(

                isExpanded: wizardStep == 1,
                canTapOnHeader: false,
                headerBuilder: (context, isExpanded) {
                  return Row(

                    children: [
                      Text("1"),
                      Text("Type"),
                    ],
                  );
                },
                body: ),
            ExpansionPanel(
                isExpanded: wizardStep == 2,
                canTapOnHeader: false,
                headerBuilder: (context, isExpanded) {
                  return SizedBox(
                    width: 300,
                    height: 300,
                    child: Row(
                      children: [
                        Text("2"),
                        Text("amount"),
                      ],
                    ),
                  );
                },
                body: Column(

                  children: [
                    TextField(
                      controller: textEditingController,
                    ),
                    ElevatedButton(
                      child: Text(S.of(context).continueButton),
                      onPressed: () {
                        setState(() {
                          wizardStep++;
                        });
                      },
                    )
                  ],
                )),
            ExpansionPanel(
                isExpanded: wizardStep == 3,
                canTapOnHeader: false,
                headerBuilder: (context, isExpanded) {
                  return Row(
                    children: [
                      Text("3"),
                      Text("account"),
                    ],
                  );
                },
                body: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(
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
                        onPressed: () {
                          setState(() {
                            wizardStep++;
                          });
                        },
                      )
                    ],
                  ),
                )),
            */
          ],
        ),
      ),
    );
  }
}
