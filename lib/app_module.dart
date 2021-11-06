import 'package:duszamobile2021/widgets/pages/tab_hoster_page.dart';
import 'package:duszamobile2021/widgets/tabs/categories_tab.dart';
import 'package:duszamobile2021/widgets/tabs/home_tab.dart';
import 'package:duszamobile2021/widgets/tabs/receipts_tab.dart';
import 'package:duszamobile2021/widgets/tabs/statistics_tab.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => TabHosterPage(), children: [
          ChildRoute("/home", child: (context, args) => HomeTab()),
          ChildRoute("/balances", child: (context, args) => ReceiptsTab()),
          ChildRoute("/categories", child: (context, args) => CategoriesTab()),
          ChildRoute("/statistics", child: (context, args) => StatisticsTab()),
        ]),
      ];
}
