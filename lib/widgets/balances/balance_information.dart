import 'package:duszamobile2021/chart_helper.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/widgets/balances/balance_monthy.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
    int itemsForBalance = account.items
        .where((element) => element.balanceId == balance.id)
        .length;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${S.of(context).type}: ${typeName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 20.0),
                ),
              ),
              ...(balance.type == BalanceType.credit
                  ? [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${S.of(context).turn}: ${Jiffy(dueDate).format("yyyy. MM. dd.")}",
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "${S.of(context).limit}: ${balance.limit!.toStringAsFixed(0)} HUF",
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ]
                  : []),
            ],
          ),
          ...(itemsForBalance != 0
              ? [
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
                            moneyChangeData(context, account, balance: balance),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: BalanceMonthy(account: account, balance: balance),
                  ),
                ]
              : [
                  Text(S.of(context).noRecordForAccount),
                ]),
        ],
      ),
    );
  }
}
