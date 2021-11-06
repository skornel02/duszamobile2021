import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:duszamobile2021/widgets/balances/balance_creator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BalancePicker extends StatelessWidget {
  final int? selectedIndex;
  final List<Balance> balances;
  final Function(int) selectIndex;
  final Function(Balance) handleCreate;

  const BalancePicker({
    Key? key,
    required this.balances,
    required this.selectedIndex,
    required this.selectIndex,
    required this.handleCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(4),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: balances.length + 1,
            itemBuilder: (context, index) {
              if (index < balances.length) {
                Balance balance = balances[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ChoiceChip(
                    labelPadding: const EdgeInsets.all(12),
                    label: Text(balance.name, style: TextStyle(fontSize: 16),),
                    selected: selectedIndex == index,
                    onSelected: (selected) {
                      selectIndex(index);
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ChoiceChip(
                    label: Text(S.of(context).addNewBalance),
                    labelPadding: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(6),
                    selected: false,
                    onSelected: (selected) {
                      Alert(
                          context: context,
                          title: S.of(context).creation,
                          content: Column(
                            children: <Widget>[
                              BalanceCreatorWidget(
                                createBalance: handleCreate,
                              ),
                            ],
                          ),
                          buttons: []).show();
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
