import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabHosterPage extends StatefulWidget {
  @override
  State<TabHosterPage> createState() => _TabHosterPageState();
}

class _TabHosterPageState extends State<TabHosterPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    int actualIndex = 0;
    String path = Modular.to.path;
    switch (path) {
      case "/balances":
        actualIndex = 1;
        break;
      case "/categories":
        actualIndex = 2;
        break;
      case "/statistics":
        actualIndex = 3;
        break;
      case "/home":
      default:
        actualIndex = 0;
        break;
    }
    if (selectedIndex != actualIndex) {
      setState(() {
        selectedIndex = actualIndex;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).appTitle),
      ),
      body: RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          switch (index) {
            case 0:
              Modular.to.navigate("/home");
              break;
            case 1:
              Modular.to.navigate("/balances");
              break;
            case 2:
              Modular.to.navigate("/categories");
              break;
            case 3:
              Modular.to.navigate("/statistics");
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
              ),
              label: S.of(context).home),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home), label: S.of(context).home),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
