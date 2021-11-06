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
  int tag = 1;

  List<String> options = [
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ChoiceChip(
                  label: Text(options[index]),
                  selected: tag == index,
                  onSelected: (selected) {
                    setState(() {
                      tag = index;
                    });
                  },
                );
              }),
          Text("${S.of(context).type}: ${"Credit card vagy mi"}"),
          Text("${S.of(context).turn}: ${"2000.01.01"}"),
          Text("Statisztikák!!!"),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
                    Expanded(child: Text("DÁTUM")),
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.arrowRight))
                  ],
                ),
                PageView.builder(itemBuilder: (context, index) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context2, index2) {
                        //  return TransactionListItem("firm", null, account, amount, balanceType);
                        return Text("");
                      });
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
