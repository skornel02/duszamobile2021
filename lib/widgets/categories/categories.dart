import 'dart:math';

import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final Account account;

  const CategoriesWidget({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        account.items.isNotEmpty
            ? SizedBox(
                height: 240,
                width: 360,
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37),
                      ),
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    )),
              )
            : SizedBox(),
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
    );
  }

  List<PieChartSectionData> showingSections() {
    int totalItems = account.items.length;
    Color a = Colors.blue;
    Color b = Colors.green;
    List<PieChartSectionData> data = [];
    flattenCategories(account.categories).forEach((category) {
      List<Item> items = account.items
          .where((element) => element.category == category)
          .toList();
      if (items.isNotEmpty) {
        data.add(PieChartSectionData(
            value: items.length.toDouble(),
            title: category,
            radius: 50.0,
            color: Color.lerp(a, b, items.length / totalItems.toDouble()),
            titleStyle: TextStyle(
              color: Colors.white,
            )));
      }
    });

    return data;
  }
}
