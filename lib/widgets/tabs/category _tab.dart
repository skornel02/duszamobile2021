import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/list_items/add_category_list_item.dart';
import 'package:duszamobile2021/widgets/list_items/category_list_item.dart';
import 'package:duszamobile2021/widgets/list_items/transaction_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CategoryMode { VIEW, EDIT }

class CategoryTab extends StatefulWidget {
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  CategoryMode mode = CategoryMode.VIEW;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mode == CategoryMode.VIEW
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Text("VALAMI STATISZTIKA JÖN IDE"),
                  DropdownButton(items: []),
                  Text("VALAMI STATISZTIKA JÖN IDE"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      // return TransactionListItem(Item());
                      return Text("Item jön ide");
                    },
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  AddCategoryListItem(
                      text: S.of(context).addNewCategory,
                      onAddButtonPressed: () {}),
                  Text("CATEGORY NAME "),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2 + 1,
                    itemBuilder: (context, index) {
                      if (index != 2) {
                        return CategoryListItem(
                          category: "Wife",
                          onPressedDeleteButton: () {},
                        );
                      } else {
                        return AddCategoryListItem(
                          text: S.of(context).addNewSubCategory,
                          onAddButtonPressed: () {},
                        );
                      }
                    },
                  ),
                  Text("Details"),
                  Text(S.of(context).latestTransactions),
                  Text(S.of(context).thisMonth),
                  Row(
                    children: [
                      Card(
                        child: Text("MÉG TÖBB PÉNZ"),
                      ),
                      Card(
                        child: Text("MÉG TÖBB PÉNZ"),
                      )
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: mode == CategoryMode.VIEW
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  mode = CategoryMode.EDIT;
                });
              },
              child: const FaIcon(FontAwesomeIcons.edit),
            )
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  mode = CategoryMode.VIEW;
                });
              },
              child: const FaIcon(FontAwesomeIcons.save),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
