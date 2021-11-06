import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/widgets/balances/balance_monthy.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:jiffy/jiffy.dart';

class BalanceInformation extends StatelessWidget {
  final Account account;
  final Balance balance;
  const BalanceInformation({
    Key? key,
    required this.account,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String typeName;
    switch (balance.type) {
      case BalanceType.cash:
        typeName = S.of(context).cash;
        break;
      case BalanceType.debit:
        typeName = S.of(context).debit;
        break;
      case BalanceType.credit:
        typeName = S.of(context).credit;
        break;
    }
    DateTime dueDate = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Column(
            children: [
              Text("${S.of(context).type}: ${typeName}"),
              ...(balance.type == BalanceType.credit
                  ? [
                      Text(
                          "${S.of(context).turn}: ${dueDate.toIso8601String()}"),
                      Text("${S.of(context).limit}: ${balance.limit}"),
                    ]
                  : []),
            ],
          ),
          SizedBox(
            height: 240,
            child: AspectRatio(
              aspectRatio: 1.70,
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    color: Color(0xff232d37)),
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
          BalanceMonthy(account: account, balance: balance),
        ],
      ),
    );
  }

  LineChartData moneyChangeData(BuildContext context) {
    int monthMax = DateTime.now().month + 1;
    int monthMin = monthMax - 12;
    Map<int, double> moneyEachMonth = {};
    for (int i = 0; i < 12; i++) {
      DateTime month =
          Jiffy(DateTime(DateTime.now().year, DateTime.now().month))
              .subtract(months: i)
              .dateTime;
      moneyEachMonth[monthMax - 1 - i] = account
              .getIncomeMonth(month.year, month.month, balance: balance) +
          account.getSpendingMonth(month.year, month.month, balance: balance);
    }

    double maxMoney = moneyEachMonth.values.reduce(max);

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
              fontSize: 16),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            if (value == maxMoney / 2 || value == maxMoney || value == 0) {
              return value.toInt().toString();
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: monthMin.toDouble(),
      maxX: monthMax.toDouble(),
      minY: 0,
      maxY: maxMoney,
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
            colors: [Theme.of(context).primaryColor]),
      ],
    );
  }
}
