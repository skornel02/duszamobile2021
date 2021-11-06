import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/widgets/tabs/category_tab.dart';
import 'package:duszamobile2021/widgets/tabs/home_tab.dart';
import 'package:duszamobile2021/widgets/tabs/balance_tab.dart';
import 'package:duszamobile2021/widgets/tabs/statistics_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabHosterPage extends StatefulWidget {

  @override
  State<TabHosterPage> createState() => _TabHosterPageState();
}

class _TabHosterPageState extends State<TabHosterPage> {
  Widget body = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).appTitle),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          switch(index){
            case 0:
              setState(() {
                body = HomeTab();
              });
              break;
            case 1:
              setState(() {
                body = BalanceTab();
              });
              break;
            case 2:
              setState(() {
                body = CategoryTab();
              });
              break;
            case 3:
              setState(() {
                body = StatisticsTab();
              });
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home, color: Colors.lightGreen,), label: S.of(context).home),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
