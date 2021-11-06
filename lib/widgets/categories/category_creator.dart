import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CategoryCreator extends StatefulWidget {
  final Function(String) createCategory;

  const CategoryCreator({Key? key, required this.createCategory})
      : super(key: key);

  @override
  _CategoryCreatorState createState() => _CategoryCreatorState();
}

class _CategoryCreatorState extends State<CategoryCreator> {
  final TextEditingController _nameController;

  _CategoryCreatorState() : _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: S.of(context).name,
          ),
        ),
        DialogButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.createCategory(_nameController.text);
              Modular.to.pop();
            }
          },
          child: Text(
            S.of(context).ok,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    );
  }
}
