import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/tabs/category_tab.dart';
import 'package:duszamobile2021/widgets/tabs/home_tab.dart';
import 'package:duszamobile2021/widgets/tabs/balance_tab.dart';
import 'package:duszamobile2021/widgets/tabs/statistics_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabHosterPage extends StatefulWidget {

  @override
  State<TabHosterPage> createState() => _TabHosterPageState();
}

class _TabHosterPageState extends State<TabHosterPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).appTitle),
      ),
      body:  RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.lightGreen,
        onTap: (index){
          switch(index){
            case 0:
              Modular.to.navigate("/home");
              setState(() {
                currentIndex = 0;
              });
              break;
            case 1:
              Modular.to.navigate("/balances");
              setState(() {
                currentIndex = 1;
              });
              break;
            case 2:
              Modular.to.navigate("/categories");
              setState(() {
                currentIndex = 2;
              });
              break;
            case 3:
              Modular.to.navigate("/statistics");
              setState(() {
                currentIndex = 3;
              });
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.balanceScale), label: S.of(context).balances),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.shapes), label: S.of(context).categories),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chartBar), label: S.of(context).statistics),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}
