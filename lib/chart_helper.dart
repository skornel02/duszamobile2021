import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:math';

LineChartData moneyChangeData(
  BuildContext context,
  Account account, {
  Balance? balance,
}) {
  int monthMax = DateTime.now().month + 1;
  int monthMin = monthMax - 12;
  Map<int, double> moneyEachMonth = {};
  Map<int, double> spendingEachMonth = {};
  Map<int, double> incomeEachMonth = {};
  for (int i = 0; i < 12; i++) {
    DateTime month = Jiffy(DateTime(DateTime.now().year, DateTime.now().month))
        .subtract(months: i)
        .dateTime;
    DateTime endOfMonth =
        Jiffy(month).add(months: 1).subtract(minutes: 1).dateTime;
    double income =
        account.getIncomeMonth(month.year, month.month, balance: balance);
    double spending =
        account.getSpendingMonth(month.year, month.month, balance: balance);
    spendingEachMonth[monthMax - 1 - i] = spending;
    incomeEachMonth[monthMax - 1 - i] = income;
    moneyEachMonth[monthMax - 1 - i] =
        account.getRunningBalance(endOfMonth, balance: balance);
  }

  double maxMoney = [
    ...moneyEachMonth.values,
    ...spendingEachMonth.values,
    ...incomeEachMonth.values
  ].reduce(max);
  double minMoney = [
    ...moneyEachMonth.values,
    ...spendingEachMonth.values,
    ...incomeEachMonth.values
  ].reduce(min);
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
      LineChartBarData(
        spots: moneyEachMonth.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList(),
        isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
            show: true, colors: [Theme.of(context).primaryColorDark]),
        colors: [Theme.of(context).primaryColor],
      ),
      LineChartBarData(
        spots: incomeEachMonth.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList(),
        isCurved: true,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        colors: [Colors.green],
      ),
      LineChartBarData(
        spots: spendingEachMonth.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList(),
        isCurved: true,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        colors: [Colors.red],
      ),
    ],
  );
}
