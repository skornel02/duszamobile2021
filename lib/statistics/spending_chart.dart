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
    items = account.items.where((element) => element.amount < 0).toList();
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
        SizedBox(
          height: 240,
          child: AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                  left: 12.0,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  moneyChangeData(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> get expensesThisMonthByCategory {
    List<PieChartSectionData> data = [];
    DateTime thisMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime endOfMonth =
        Jiffy(thisMonth).add(months: 1).subtract(minutes: 1).dateTime;
    List<Item> items =
        filterItemsForRange(this.items, thisMonth, endOfMonth).toList();

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
          title: spentOnCategory.toStringAsFixed(0),
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

  LineChartData moneyChangeData(BuildContext context) {
    int monthMax = DateTime.now().month + 1;
    int monthMin = monthMax - 12;
    Map<int, Map<String, double>> categoryMoneyEachMonth = {};

    for (int i = 0; i < 12; i++) {
      DateTime month =
          Jiffy(DateTime(DateTime.now().year, DateTime.now().month))
              .subtract(months: i)
              .dateTime;
      DateTime endOfMonth =
          Jiffy(month).add(months: 1).subtract(minutes: 1).dateTime;
      List<Item> items = filterItemsForRange(account.items, month, endOfMonth);
      Map<String, double> monthlySpent = {};

      for (var category in categories) {
        double totalSpent = items
                .where((element) => element.category == category)
                .map((e) => e.amount)
                .sum *
            -1;
        monthlySpent[category] = totalSpent;
      }

      categoryMoneyEachMonth[monthMax - 1 - i] = monthlySpent;
    }
    List<double> allValues = [];
    for (var month in categoryMoneyEachMonth.values) {
      allValues.addAll(month.values);
    }

    double maxMoney = 0;
    double minMoney = 0;
    try {
      maxMoney = allValues.reduce(max);
      minMoney = allValues.reduce(min);
    } catch (err) {}
    double range = maxMoney - minMoney;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            int wholeValue = value.toInt();
            int shifted = (wholeValue - 1) % 12 + 1;
            return "$shifted.";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: range == 0 ? 1 : (range / 10).roundToDouble(),
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: monthMin.toDouble(),
      maxX: monthMax.toDouble(),
      minY: minMoney - (range / 10),
      maxY: maxMoney + (range / 10),
      lineBarsData: [
        ...categories
            .map(
              (category) => LineChartBarData(
                spots: categoryMoneyEachMonth.entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value[category]!))
                    .toList(),
                isCurved: true,
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(show: false),
                colors: [categoryColorMap[category]!],
              ),
            )
            .toList(),
      ],
    );
  }
}
