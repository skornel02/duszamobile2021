import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/list_items/add_category_list_item.dart';
import 'package:duszamobile2021/widgets/list_items/category_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(

          children: <Widget>[
            AddCategoryListItem(text: S.of(context).addNewCategory, onAddButtonPressed: (){

            }),
            Text("CATEGORY NAME "),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2+1,
              itemBuilder: (context, index){
                if(index != 2){
                  return CategoryListItem(category: "Wife", onPressedDeleteButton: (){

                  },);
                }else{
                  return AddCategoryListItem(text: S.of(context).addNewSubCategory, onAddButtonPressed: (){

                  },);
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const FaIcon(FontAwesomeIcons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
