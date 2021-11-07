import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BalanceChangesChart extends StatelessWidget {
  final Account account;

  const BalanceChangesChart({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            child: BarChart(BarChartData(
              barGroups: balancesChangeData,
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  getTitles: (value) => account.balances[value.toInt()].name,
                ),
                topTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(showTitles: false),
              ),
            )),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> get balancesChangeData {
    List<BarChartGroupData> data = [];
    int x = 0;
    account.balances.forEach((balance) {
      double income = account.getIncomeMonth(
          DateTime.now().year, DateTime.now().month,
          balance: balance);
      double expenses = account.getSpendingMonth(
          DateTime.now().year, DateTime.now().month,
          balance: balance);
      data.add(
        BarChartGroupData(
          x: x++,
          barRods: [
            BarChartRodData(
              y: income,
              colors: [Colors.green],
            ),
            BarChartRodData(
              y: expenses * -1,
              colors: [Colors.red],
            ),
          ],
        ),
      );
    });
    return data;
  }
}
