import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/list_items/transaction_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceTab extends StatefulWidget {
  @override
  State<BalanceTab> createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {
  int? balanceChipSelectedIndex;

  List<String> balanceChipOptions = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox( height: 100,
              child: ListView.builder(

                  padding: const EdgeInsets.all(4),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: balanceChipOptions.length,
                  itemBuilder: (context, index) {
                    return ChoiceChip(
                      label: Text(balanceChipOptions[index]),
                      selected: balanceChipSelectedIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          balanceChipSelectedIndex = index;
                        });
                      },
                    );
                  }),
            ),

            Expanded(
              child: Column(
                children: [
                  Text("${S.of(context).type}: ${"Credit card vagy mi"}"),
                  Text("${S.of(context).turn}: ${"2000.01.01"}"),
                  Text("Statisztikák!!!"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
                      Text("DÁTUM"),
                      IconButton(
                          onPressed: () {},
                          icon: const FaIcon(FontAwesomeIcons.arrowRight))
                    ],
                  ),
                  SizedBox(
                    width: 300, height: 300,
                    child: PageView.builder(itemBuilder: (context, index) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context2, index2) {
                            //  return TransactionListItem(item);
                            return Text("ASD");
                          });
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: FaIcon(FontAwesomeIcons.dollarSign),onPressed: (){

      },),
    );
  }
}
