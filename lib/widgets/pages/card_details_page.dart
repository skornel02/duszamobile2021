import 'package:date_time_picker/date_time_picker.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CardDetailsPage extends StatefulWidget {
  String itemId;

  CardDetailsPage(this.itemId);

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  Account account;

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  MoneyMaskedTextController amountTextEditingController =
      MoneyMaskedTextController(
          rightSymbol: " HUF",
          decimalSeparator: "",
          thousandSeparator: " ",
          precision: 0); //after

  DateTime? selectedDateTime;

  Item? item;

  String? selectedCategory;
  List<DropdownMenuItem> categories = [];

  Balance? selectedBalance;
  List<DropdownMenuItem> balances = [];

  bool isIncome = true;
  bool isSingle = true;

  int incomeToggleIndex = 0;
  int singleToggleIndex = 0;

  _CardDetailsPageState()
      : account = Modular.get<AccountRepository>().getAccount();

  @override
  void initState() {
    super.initState();
    flattenCategories(account.categories).forEach((element) {
      categories.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    item = account.getItemFromId(widget.itemId);

    titleTextEditingController.text = item!.title;
    dateTextEditingController.text = item!.creation.toString();
    selectedCategory = item!.category;
    selectedBalance = account.getBalanceFromId(item!.balanceId);
    account.balances.forEach((element) {
      balances.add(DropdownMenuItem(
        child: Text(element.name),
        value: element,
      ));
    });
    amountTextEditingController.text = item!.amount.toString();

    isSingle = !item!.monthly;
    if (isSingle)
      singleToggleIndex = 0;
    else
      singleToggleIndex = 1;
    isIncome = item!.amount > 0;
    if (isIncome)
      incomeToggleIndex = 0;
    else
      incomeToggleIndex = 1;
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
      body: Padding(
        padding: const EdgeInsets.only(top: 12, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item!.title, style: TextStyle(fontSize: 20),),
                IconButton(icon: FaIcon(FontAwesomeIcons.edit), onPressed: () {
                  // TODO: popup
                },),
              ],
            ),
            */

            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: S.of(context).title),
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

                  DateTime? pickedDateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
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

            // TODO: csatolmányokat megcsinálni
            Text("Csatolmányok???"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.save),
        onPressed: () {
          // TODO: save item

          Modular.to.pop();
        },
      ),
    );
  }
}
