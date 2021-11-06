import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/wizards/simple_item_wizard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Come { INCOME, OUTCOME }

class AdvancedWizardPage extends StatefulWidget {
  @override
  State<AdvancedWizardPage> createState() => _AdvancedWizardPageState();
}

class _AdvancedWizardPageState extends State<AdvancedWizardPage> {
  Account account;

  Come come = Come.INCOME;
  int? balanceChipSelectedIndex;

  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();

  List<DropdownMenuItem> categories = [];

  String? selectedCategory;
  DateTime? selectedDateTime;

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
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: account.balances.length,
                        itemBuilder: (context, index) {
                          return ChoiceChip(
                            label: Text(account.balances[index].name),
                            selected: balanceChipSelectedIndex == index,
                            onSelected: (selected) {
                              setState(() {
                                balanceChipSelectedIndex = index;
                              });
                            },
                          );
                        }),
                  ),
                  RadioListTile(
                      title: Text(S.of(context).income),
                      value: Come.INCOME,
                      groupValue: come,
                      onChanged: (c) {
                        setState(() {
                          come = Come.INCOME;
                        });
                      }),
                  RadioListTile(
                      title: Text(S.of(context).outcome),
                      value: Come.OUTCOME,
                      groupValue: come,
                      onChanged: (c) {
                        setState(() {
                          come = Come.OUTCOME;
                        });
                      }),
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
                    padding: const EdgeInsets.all(4),
                    child: Text(
                        "${S.of(context).name}, ${S.of(context).dateCategory}"),
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
                      amountTextEditingController.text != "")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Item item = Item(
                                title: nameTextEditingController.text,
                                amount: int.parse(
                                        amountTextEditingController.text) *
                                    (come == Come.INCOME ? 1 : -1),
                                balance:
                                    account.balances[balanceChipSelectedIndex!],
                                category: selectedCategory!,
                                creation: selectedDateTime!,
                                // TODO: monthly
                                monthly: false,
                              );
                              createItem(item);
                            },
                            child: Text(S.of(context).finishButton))
                      ],
                    )
                  /*
                  InputDatePickerFormField(

                    onDateSaved: (date){
                      setState(() {
                        choosedDateTime = date;
                      });
                    },
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 10)),
                    fieldHintText: S.of(context).chooseDate,
                  )

                   */
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
