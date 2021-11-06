import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool?> showAreYouSureRemoveDialog(
    BuildContext context, Function onRemove) {
  return Alert(
    context: context,
    type: AlertType.warning,
    title: S.of(context).remove,
    desc: S.of(context).areYouSure,
    buttons: [
      DialogButton(
        child: Text(
          S.of(context).ok.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          onRemove();
          Modular.to.pop();
        },
        color: Theme.of(context).errorColor,
      ),
      DialogButton(
        child: Text(
          S.of(context).cancel.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          Modular.to.pop();
        },
        width: 120,
        color: Theme.of(context).disabledColor,
      )
    ],
  ).show();
  ;
}
