import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/list_items/item_item.dart';

import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State implements Disposable {
  AccountRepository repo;
  late Account account;
  late VoidCallback listener;

  _HomeTabState() : repo = Modular.get<AccountRepository>() {
    account = repo.getAccount();
  }

  @override
  void initState() {
    super.initState();
    print("REGISTERING");
    repo.addListener(handleAccountChange);
  }

  @override
  void dispose() {
    repo.removeListener(handleAccountChange);
    print("DEREGISTERING");
    super.dispose();
  }

  void handleAccountChange() {
    setState(() {
      account = repo.getAccount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Card(
                  margin: const EdgeInsets.only(top: 24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).accountwideBalance,
                              style: const TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${account.getRunningBalance(DateTime.now()).toStringAsFixed(0)} HUF",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                child: Align(
                  child: Text(
                    S.of(context).thisMonth,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).income,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              "${account.getIncomeMonth(DateTime.now().year, DateTime.now().month).toStringAsFixed(0)} HUF",
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).outcome,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              "${account.getSpendingMonth(DateTime.now().year, DateTime.now().month).toStringAsFixed(0)} HUF",
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    S.of(context).latestTransactions,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: account.lastSortedItems.take(3).length,
                itemBuilder: (context, index) {
                  Item item = account.lastSortedItems[index];

                  return ItemWidget(item: item);
                },
                physics: const NeverScrollableScrollPhysics(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(S.of(context).details),
                  IconButton(
                    onPressed: () {
                      Modular.to.navigate("/balances");
                    },
                    icon: const FaIcon(FontAwesomeIcons.chevronRight),
                  ),
                ],
              ),
              ...(account.creditBalances.isNotEmpty
                  ? [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            S.of(context).creditCards,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 20.0),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: account.creditBalances.length,
                        itemBuilder: (context, index) {
                          Balance creditBalance = account.creditBalances[index];
                          DateTime dueDate = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              creditBalance.dayOfMonth ?? -1);
                          if (dueDate.isBefore(DateTime.now())) {
                            dueDate = Jiffy(dueDate).add(months: 1).dateTime;
                          }
                          double daysRemaining = Jiffy(dueDate)
                              .diff(Jiffy(DateTime.now()), Units.DAY)
                              .toDouble();

                          double currentBudget = account.getRunningBalance(
                            DateTime.now(),
                            balance: creditBalance,
                          );

                          bool overBudget =
                              currentBudget < (0 - (creditBalance.limit ?? 0));

                          bool alert =
                              creditBalance.limit != null && overBudget;

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  18.0, 12.0, 12.0, 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${creditBalance.name}: ${daysRemaining.toStringAsFixed(0)} ${S.of(context).daysRemaining}",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  alert
                                      ? Text(S.of(context).overBudget,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.red))
                                      : Text(
                                          S.of(context).notOverBudget,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ]
                  : []),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          if (account.balances.isEmpty) {
            Fluttertoast.showToast(
              msg: S.of(context).cantWithoutBalance,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.orange,
            );
            Modular.to.navigate("/balances");
            return;
          }
          Modular.to.pushNamed("/wizard");
        },
      ),
    );
  }
}
