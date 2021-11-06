import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/list_items/add_category_list_item.dart';
import 'package:duszamobile2021/widgets/list_items/category_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditCategoriesWidget extends StatelessWidget {
  final Map<String, List<String>> categories;
  final Function(String) addCategory;
  final Function(String) removeCategory;
  final Function(String, String) addSubcategory;
  final Function(String, String) removeSubcategory;

  const EditCategoriesWidget({
    Key? key,
    required this.categories,
    required this.addCategory,
    required this.removeCategory,
    required this.addSubcategory,
    required this.removeSubcategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AddCategoryListItem(
              text: S.of(context).addNewCategory,
              onAddButtonPressed: () {
                // TODO: Popup, ask for name
                String name = "heyyyy";
                addCategory(name);
              }),
          ListView.builder(
            itemCount: categories.keys.length,
            itemBuilder: (context, index) {
              String category = categories.keys.elementAt(index);
              List<String> subCategories = categories[category]!;

              return Column(
                children: [
                  Text(category),
                  IconButton(
                    onPressed: () {
                      // TODO: PROMPT FOR CONFIRMATION
                      removeCategory(category);
                    },
                    icon: const FaIcon(FontAwesomeIcons.trash),
                  ),
                  ListView.builder(
                    itemCount: subCategories.length,
                    itemBuilder: (context, index) {
                      String subcategory = subCategories[index];
                      return CategoryListItem(
                        category: subcategory,
                        onPressedDeleteButton: () {
                          // TODO: PROMPT FOR CONFIRMATION
                          removeSubcategory(category, subcategory);
                        },
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  AddCategoryListItem(
                    text: S.of(context).addNewSubCategory,
                    onAddButtonPressed: () {
                      // TODO: PROMPT NAME
                      String subcategory = "HEYYY";
                      addSubcategory(category, subcategory);
                    },
                  )
                ],
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
