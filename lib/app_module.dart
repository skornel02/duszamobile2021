import 'package:duszamobile2021/widgets/pages/tab_hoster_page.dart';
import 'package:duszamobile2021/widgets/pages/wizard_page.dart';
import 'package:duszamobile2021/widgets/tabs/balance_tab.dart';
import 'package:duszamobile2021/widgets/tabs/category_tab.dart';
import 'package:duszamobile2021/widgets/tabs/home_tab.dart';
import 'package:duszamobile2021/widgets/tabs/statistics_tab.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => TabHosterPage(), children: [
          ChildRoute("/home", child: (context, args) => HomeTab()),
          ChildRoute("/balances", child: (context, args) => BalanceTab()),
          ChildRoute("/categories", child: (context, args) => CategoryTab()),
          ChildRoute("/statistics", child: (context, args) => StatisticsTab()),
        ]),
        ChildRoute("/wizard", child: (context, args) => WizardPage())
      ];
}
