import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("${S.of(context).type}: ${"Credit card vagy mi"}"),
                    Text("${S.of(context).turn}: ${"2000.01.01"}"),
                    Text("Statisztikák!!!"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
                  Text("DÁTUM"),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.arrowRight))
                ],
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: PageView.builder(itemBuilder: (context, index) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context2, index2) {
                        //  return TransactionListItem(item);
                        return Text("ASD");
                      });
                }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
