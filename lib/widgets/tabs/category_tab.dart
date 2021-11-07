import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/widgets/categories/categories.dart';
import 'package:duszamobile2021/widgets/categories/edit_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CategoryMode { VIEW, EDIT }

class CategoryTab extends StatefulWidget {
  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  CategoryMode mode = CategoryMode.VIEW;
  Account account;

  _CategoryTabState() : account = Modular.get<AccountRepository>().getAccount();

  addCategory(String category) {
    if (!account.categories.containsKey(category)) {
      Account next = Account.copy(account);
      Map<String, List<String>> nextCategories = Map.from(next.categories);
      nextCategories[category] = [];
      next.categories = nextCategories;
      Modular.get<AccountRepository>().saveAccount(next);
      setState(() {
        account = next;
      });
      Fluttertoast.showToast(
        msg: S.current.categoryCreated,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: S.current.categoryNameAlreadyInUse,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  addSubcategory(String category, String subcategory) {
    if (!(account.categories[category]?.contains(subcategory) ?? false)) {
      Account next = Account.copy(account);
      Map<String, List<String>> nextCategories = Map.from(next.categories);
      nextCategories.putIfAbsent(category, () => []).add(subcategory);
      next.categories = nextCategories;
      Modular.get<AccountRepository>().saveAccount(next);
      setState(() {
        account = next;
      });
      Fluttertoast.showToast(
        msg: S.current.subcategoryCreated,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: S.current.subcategoryNameAlreadyInUse,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  removeCategory(String category) {
    if (account.categories[category]?.isEmpty ?? false) {
      Account next = Account.copy(account);
      Map<String, List<String>> nextCategories = Map.from(next.categories);
      nextCategories.remove(category);
      next.categories = nextCategories;
      Modular.get<AccountRepository>().saveAccount(next);
      setState(() {
        account = next;
      });
      Fluttertoast.showToast(
        msg: S.current.removeSuccessful,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: S.current.categoryNameInUse,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  removeSubcategory(String category, String subcategory) {
    String fullCategory = "${category}/${subcategory}";
    var usage = account.getCategoryUsage();
    if (!usage.containsKey(fullCategory) || usage[fullCategory] == 0) {
      Account next = Account.copy(account);
      Map<String, List<String>> nextCategories = Map.from(next.categories);
      nextCategories.putIfAbsent(category, () => []).remove(subcategory);
      next.categories = nextCategories;
      Modular.get<AccountRepository>().saveAccount(next);
      setState(() {
        account = next;
      });
      Fluttertoast.showToast(
        msg: S.current.removeSuccessful,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: S.current.subcategoryNameInUse,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: mode == CategoryMode.VIEW
            ? CategoriesWidget(
                account: account,
              )
            : EditCategoriesWidget(
                categories: account.categories,
                addCategory: addCategory,
                removeCategory: removeCategory,
                addSubcategory: addSubcategory,
                removeSubcategory: removeSubcategory,
              ),
      ),
      floatingActionButton: mode == CategoryMode.VIEW
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  mode = CategoryMode.EDIT;
                });
              },
              child: const FaIcon(FontAwesomeIcons.edit),
            )
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  mode = CategoryMode.VIEW;
                });
              },
              child: const FaIcon(FontAwesomeIcons.stepBackward),
            ),
    );
  }
}
