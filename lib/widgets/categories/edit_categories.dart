import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/categories/category_creator.dart';
import 'package:duszamobile2021/widgets/dialog_helper.dart';
import 'package:duszamobile2021/widgets/list_items/add_category_list_item.dart';
import 'package:duszamobile2021/widgets/list_items/category_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Column(
          children: <Widget>[
            AddCategoryListItem(
                text: S.of(context).addNewCategory,
                onAddButtonPressed: () {
                  Alert(
                      context: context,
                      title: S.of(context).creation,
                      content: Column(
                        children: <Widget>[
                          CategoryCreator(
                            createCategory: (name) {
                              addCategory(name);
                            },
                          ),
                        ],
                      ),
                      buttons: []).show();
                }),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                itemCount: categories.keys.length,
                itemBuilder: (context, index) {
                  String category = categories.keys.elementAt(index);
                  List<String> subCategories = categories[category]!;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(category, style: TextStyle(fontSize: 20),),
                          IconButton(
                            onPressed: () {
                              showAreYouSureRemoveDialog(context, () {
                                removeCategory(category);
                              });
                            },
                            icon: const FaIcon(FontAwesomeIcons.trash),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListView.builder(
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            String subcategory = subCategories[index];
                            return CategoryListItem(
                              category: subcategory,
                              onPressedDeleteButton: () {
                                showAreYouSureRemoveDialog(context, () {
                                  removeSubcategory(category, subcategory);
                                });
                              },
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: AddCategoryListItem(
                          text: S.of(context).addNewSubCategory,
                          onAddButtonPressed: () {
                            Alert(
                                context: context,
                                title: S.of(context).creation,
                                content: Column(
                                  children: <Widget>[
                                    CategoryCreator(
                                      createCategory: (name) {
                                        addSubcategory(category, name);
                                      },
                                    ),
                                  ],
                                ),
                                buttons: []).show();
                          },
                        ),
                      )
                    ],
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }
}
