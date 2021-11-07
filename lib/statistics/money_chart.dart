import 'package:duszamobile2021/chart_helper.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/indicator.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:jiffy/jiffy.dart';

class MoneyChart extends StatelessWidget {
  final Account account;
  final Map<String, Color> colorMap;

  const MoneyChart({
    Key? key,
    required this.account,
    required this.colorMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5.0,
          children: [
            Indicator(color: Colors.green, text: S.of(context).income, isSquare: true),
            Indicator(color: Colors.red, text: S.of(context).outcome, isSquare: true),
            Indicator(
                color: Theme.of(context).primaryColor,
                text: "_TOTAL",
                isSquare: true),
            ...account.balances
                .map((balance) => Indicator(
                      color: colorMap[balance.id]!,
                      text: balance.name,
                      isSquare: false,
                      size: 16,
                      textColor: Colors.black,
                    ))
                .toList()
          ],
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
                  moneyChangeData(context, account),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData moneyChangeData(
    BuildContext context,
    Account account,
  ) {
    int monthMax = DateTime.now().month + 1;
    int monthMin = monthMax - 12;
    Map<int, double> moneyEachMonth = {};
    Map<int, double> spendingEachMonth = {};
    Map<int, double> incomeEachMonth = {};
    Map<Balance, Map<int, double>> balanceTotalEachMonth = {};
    for (var balance in account.balances) {
      balanceTotalEachMonth[balance] = {};
    }

    for (int i = 0; i < 12; i++) {
      DateTime month =
          Jiffy(DateTime(DateTime.now().year, DateTime.now().month))
              .subtract(months: i)
              .dateTime;
      DateTime endOfMonth =
          Jiffy(month).add(months: 1).subtract(minutes: 1).dateTime;
      double income = account.getIncomeMonth(month.year, month.month);
      double spending = account.getSpendingMonth(month.year, month.month);
      spendingEachMonth[monthMax - 1 - i] = spending;
      incomeEachMonth[monthMax - 1 - i] = income;
      moneyEachMonth[monthMax - 1 - i] = account.getRunningBalance(endOfMonth);
      for (var balance in account.balances) {
        balanceTotalEachMonth[balance]![monthMax - 1 - i] =
            account.getRunningBalance(endOfMonth, balance: balance);
      }
    }
    List<double> allValues = [
      ...moneyEachMonth.values,
      ...spendingEachMonth.values,
      ...incomeEachMonth.values,
    ];
    for (var balance in account.balances) {
      allValues.addAll(balanceTotalEachMonth[balance]!.values);
    }

    double maxMoney = allValues.reduce(max);
    double minMoney = allValues.reduce(min);
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
        ...account.balances
            .map(
              (balance) => LineChartBarData(
                spots: balanceTotalEachMonth[balance]!
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
                isCurved: true,
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                ),
                colors: [colorMap[balance.id]!],
              ),
            )
            .toList(),
      ],
    );
  }
}
