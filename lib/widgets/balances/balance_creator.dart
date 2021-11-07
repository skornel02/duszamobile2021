import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/resources/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BalanceCreatorWidget extends StatefulWidget {
  final Function(Balance) createBalance;

  const BalanceCreatorWidget({Key? key, required this.createBalance})
      : super(key: key);

  @override
  _BalanceCreatorWidgetState createState() => _BalanceCreatorWidgetState();
}

class _BalanceCreatorWidgetState extends State<BalanceCreatorWidget> {
  final TextEditingController _nameController;
  final TextEditingController _dayController;
  final TextEditingController _limitController;
  BalanceType balanceType = BalanceType.cash;

  final _formKey = GlobalKey<FormState>();

  _BalanceCreatorWidgetState()
      : _nameController = TextEditingController(),
        _dayController = TextEditingController(text: "1"),
        _limitController = TextEditingController(text: "0");

  String? dayValidator(String? value) {
    if (value == null) {
      return S.current.cantBeNull;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return S.current.cantBeNull;
    }
    if (n > 31) {
      return S.current.cantBeOver31;
    }
    if (n <= 0) {
      return S.current.cantBeNegative;
    }
    return null;
  }

  String? limitValidator(String? value) {
    if (value == null) {
      return S.current.cantBeNull;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return S.current.cantBeNull;
    }
    if (n < 0) {
      return S.current.cantBeNegative;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    int toggleIndex = 0;
    switch (balanceType) {
      case BalanceType.cash:
        toggleIndex = 0;
        break;
      case BalanceType.debit:
        toggleIndex = 1;
        break;
      case BalanceType.credit:
        toggleIndex = 2;
        break;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            validator: (input) {
              if (input == null || input.isEmpty)
                return S.of(context).cantBeNull;

              return null;
            },
            decoration: InputDecoration(
              labelText: S.of(context).name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleSwitch(
                initialLabelIndex: toggleIndex,
                totalSwitches: 3,
                minWidth: 100,
                labels: [
                  S.of(context).cash,
                  S.of(context).debit,
                  S.of(context).credit
                ],
                onToggle: (index) {
                  setState(() {
                    switch (index) {
                      case 0:
                        balanceType = BalanceType.cash;
                        break;
                      case 1:
                        balanceType = BalanceType.debit;
                        break;
                      case 2:
                        balanceType = BalanceType.credit;
                        break;
                    }
                  });
                },
                animate: true,
                animationDuration: 250,
              ),
            ),
          ),
          ...(balanceType == BalanceType.credit
              ? [
                  TextFormField(
                    controller: _limitController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.always,
                    validator: limitValidator,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: S.of(context).limit,
                    ),
                  ),
                  TextFormField(
                    controller: _dayController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.always,
                    validator: dayValidator,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: S.of(context).billingDay,
                    ),
                  ),
                ]
              : []),
          DialogButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Balance balance;
                if (balanceType != BalanceType.credit) {
                  balance = Balance(balanceType, _nameController.text);
                } else {
                  balance = Balance.credit(
                    _nameController.text,
                    int.parse(_dayController.text),
                    double.parse(_limitController.text),
                  );
                }
                widget.createBalance(balance);
                Modular.to.pop();
              }
            },
            child: Text(
              S.of(context).ok,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
