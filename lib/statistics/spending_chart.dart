import 'dart:math';

import 'package:duszamobile2021/indicator.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:collection/collection.dart';

class SpendingChart extends StatelessWidget {
  final Account account;
  final Map<String, Color> categoryColorMap;

  late List<Item> items;
  late List<String> categories;

  SpendingChart({
    Key? key,
    required this.account,
    required this.categoryColorMap,
  }) : super(key: key) {
    DateTime thisMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime endOfMonth =
        Jiffy(thisMonth).add(months: 1).subtract(minutes: 1).dateTime;
    items = filterItemsForRange(account.items, thisMonth, endOfMonth)
        .where((element) => element.amount < 0)
        .toList();
    categories = items.map((e) => e.category).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5.0,
          children: categories
              .map((category) => Indicator(
                    color: categoryColorMap[category]!,
                    text: category,
                    isSquare: false,
                    size: 16,
                    textColor: Colors.black,
                  ))
              .toList(),
        ),
        SizedBox(
          height: 240,
          width: 360,
          child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: expensesThisMonthByCategory,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  List<PieChartSectionData> get expensesThisMonthByCategory {
    List<PieChartSectionData> data = [];

    double totalSpent = items.map((e) => e.amount).sum * -1;

    for (var category in categories) {
      double spentOnCategory = items
              .where((element) => element.category == category)
              .map((e) => e.amount)
              .sum *
          -1;

      data.add(
        PieChartSectionData(
          value: spentOnCategory,
          title: category,
          radius: 50.0,
          color: categoryColorMap[category] ??
              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
          titleStyle: const TextStyle(
            color: Colors.black,
            backgroundColor: Colors.grey,
          ),
          borderSide: const BorderSide(
            width: 0.3,
          ),
        ),
      );
    }

    return data;
  }
}
