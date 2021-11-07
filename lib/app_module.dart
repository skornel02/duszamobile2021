import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/repositories/local_account_repostiroy.dart';
import 'package:duszamobile2021/widgets/pages/advanced_wizard_page.dart';
import 'package:duszamobile2021/widgets/pages/card_details_page.dart';
import 'package:duszamobile2021/widgets/pages/tab_hoster_page.dart';
import 'package:duszamobile2021/widgets/pages/transaction_wizard_page.dart';
import 'package:duszamobile2021/widgets/pages/wizard_page.dart';
import 'package:duszamobile2021/widgets/tabs/balance_tab.dart';
import 'package:duszamobile2021/widgets/tabs/category_tab.dart';
import 'package:duszamobile2021/widgets/tabs/home_tab.dart';
import 'package:duszamobile2021/widgets/tabs/statistics_tab.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        AsyncBind<AccountRepository>((i) async =>
            LocalAccountRepository(await SharedPreferences.getInstance())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => TabHosterPage(), children: [
          ChildRoute("/home", child: (context, args) => HomeTab()),
          ChildRoute("/balances", child: (context, args) => BalanceTab()),
          ChildRoute("/categories", child: (context, args) => CategoryTab()),
          ChildRoute("/statistics", child: (context, args) => StatisticsTab()),
        ]),
        ChildRoute("/wizard", child: (context, args) => WizardPage()),
        ChildRoute("/wizard/advanced",
            child: (context, args) => AdvancedWizardPage()),
        ChildRoute("/items/:id",
            child: (context, args) => CardDetailsPage(itemId: args.params["id"])),
        ChildRoute("/transaction-wizard",
            child: (context, args) => TransactionWizardPage())
      ];
}
