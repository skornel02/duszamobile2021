
import 'dart:io';

import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CardDetailsPage extends StatefulWidget {
  final String itemId;

  const CardDetailsPage({Key? key, required this.itemId}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<CardDetailsPage> createState() => _CardDetailsPageState(itemId);
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  Account account;
  late Item item;

  TextEditingController titleTextEditingController;
  TextEditingController dateTextEditingController;
  late MoneyMaskedTextController amountTextEditingController;

  late DateTime selectedDateTime;

  late String selectedCategory;
  List<DropdownMenuItem> categories = [];

  late Balance selectedBalance;
  List<DropdownMenuItem> balances = [];

  late bool isIncome;
  late bool isSingle;

  int incomeToggleIndex = 0;
  int singleToggleIndex = 0;

  List<String> filePaths = [];

  _CardDetailsPageState(String id)
      : account = Modular.get<AccountRepository>().getAccount(),
        titleTextEditingController = TextEditingController(),
        dateTextEditingController = TextEditingController() {
    item = account.items.firstWhere((element) => element.id == id);
    selectedDateTime = item.creation;
    titleTextEditingController.text = item.title;
    dateTextEditingController.text = DateFormat('yyyy.MM.dd, HH:mm:ss').format(item.creation);
    amountTextEditingController = MoneyMaskedTextController(
      initialValue: item.amount,
      rightSymbol: " HUF",
      decimalSeparator: "",
      thousandSeparator: " ",
      precision: 0,
    );
    selectedCategory = item.category;
    selectedBalance = account.getBalanceFromId(item.balanceId)!;
    isSingle = !item.monthly;
    isIncome = item.amount >= 0;
  }

  @override
  void initState() {
    super.initState();
    flattenCategories(account.categories).forEach((element) {
      categories.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    for (var element in account.balances) {
      balances.add(DropdownMenuItem(
        child: Text(element.name),
        value: element,
      ));
    }

    singleToggleIndex = isSingle ? 0 : 1;
    incomeToggleIndex = isIncome ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).details),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration:
                      InputDecoration(
                        hintText: S.of(context).title
                      ),
                  controller: titleTextEditingController,
                ),
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
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                      hintText: S.of(context).chooseDate),
                  controller: dateTextEditingController,
                  onTap: () async {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());

                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      currentTime: selectedDateTime,
                      minTime: Jiffy(DateTime.now()).subtract(years: 1).dateTime,
                      maxTime: Jiffy(DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day))
                          .add(days: 1)
                          .subtract(seconds: 1)
                          .dateTime,
                      onChanged: (date) {
                        setState(() {
                          selectedDateTime = date;
                          dateTextEditingController.text =
                              DateFormat('yyyy.MM.dd, HH:mm:ss').format(selectedDateTime);
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          selectedDateTime = date;
                          dateTextEditingController.text =
                              DateFormat('yyyy.MM.dd, HH:mm:ss').format(selectedDateTime);
                        });
                      },
                      locale: LocaleType.en,
                    );
                  },
                ),
              ),
              /*
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                      hintText: S.of(context).chooseDate),
                  controller: dateTextEditingController,
                  onTap: () async {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());


                    TimeOfDay? pickedDateTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),

                        lastDate: DateTime.now());
                    if (pickedDateTime != null) {

                      setState(() {
                        dateTextEditingController.text =
                            pickedDateTime.toString();
                        selectedDateTime = pickedDateTime;
                      });
                    }

                  },
                ),
              ),
              */

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
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField(
                  value: selectedBalance,
                  onChanged: (dynamic selectedItem) {
                    selectedBalance = selectedItem;
                  },
                  decoration: InputDecoration.collapsed(
                      hintText: S.of(context).chooseCategory),
                  items: balances,
                ),
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

              if(!kIsWeb) Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ElevatedButton(onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                      if (result != null) {
                        String path = result!.files!.single!.path!;
                        File file = File(path);
                        setState(() {
                          filePaths.add(path);
                        });

                      } else {
                        // User canceled the picker
                      }


                    }, child: Text(S.of(context).chooseAttachments)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                  //  height: 200,
                  //  width: 400,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filePaths.length,
                        itemBuilder: (context, index){
                          List<String> list = filePaths[index].split("/");
                          return Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(list[list.length-1]),
                                ),
                                Spacer(),
                                IconButton(onPressed: (){
                                  setState(() {
                                    filePaths.removeAt(index);
                                  });
                                }, icon: const FaIcon(FontAwesomeIcons.times))
                              ],
                            )
                          );
                        }),
                  )
                ],
              )


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.save),
        onPressed: () {
          Item nextItem = Item.copy(item);
          nextItem.title = titleTextEditingController.text;
          nextItem.amount =
              amountTextEditingController.numberValue * (isIncome ? 1 : -1);
          nextItem.category = selectedCategory;
          nextItem.creation = selectedDateTime;
          nextItem.balanceId = selectedBalance.id;
          nextItem.filePaths = filePaths;
          Account next = Account.copy(account);
          next.items = [
            ...account.items.where((element) => element.id != item.id),
            nextItem
          ];
          Modular.get<AccountRepository>().saveAccount(next);
          Modular.to.pop();
          Modular.to.navigate("/home");
        },
      ),
    );
  }
}
