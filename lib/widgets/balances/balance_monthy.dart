import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/list_items/item_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

class BalanceMonthy extends StatefulWidget {
  final Account account;
  final Balance balance;

  const BalanceMonthy({
    Key? key,
    required this.account,
    required this.balance,
  }) : super(key: key);

  @override
  _BalanceMonthyState createState() => _BalanceMonthyState();
}

class _BalanceMonthyState extends State<BalanceMonthy> {
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    List<Item> items = filterItemsForRange(
      widget.account.items,
      selectedDate,
      Jiffy(selectedDate).add(months: 1).subtract(seconds: 1).dateTime,
      balance: widget.balance,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    selectedDate =
                        Jiffy(selectedDate).subtract(months: 1).dateTime;
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
            Text(Jiffy(selectedDate).format("yyyy/MM")),
            IconButton(
                onPressed: selectedDate.year == DateTime.now().year &&
                        selectedDate.month == DateTime.now().month
                    ? null
                    : () {
                        setState(() {
                          selectedDate =
                              Jiffy(selectedDate).add(months: 1).dateTime;
                        });
                      },
                icon: const FaIcon(FontAwesomeIcons.arrowRight))
          ],
        ),
        // TODO: Fix scrolling
        SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items[index];

                return ItemWidget(item: item);
              }),
        ),
      ],
    );
  }
}
