import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final Map<String, List<String>> categories;

  const CategoriesWidget({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("VALAMI STATISZTIKA JÖN IDE"),
        DropdownButton(items: []),
        Text("VALAMI STATISZTIKA JÖN IDE"),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            // return TransactionListItem(Item());
            return Text("Item jön ide");
          },
        ),
      ],
    );
  }
}
