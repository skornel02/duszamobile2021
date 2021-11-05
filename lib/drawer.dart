import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Drawer drawer(BuildContext context){
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.home),
          title: Text(S.of(context).home),
          onTap: (){
            // kiugrik a drawerből
            Modular.to.pop();
            Modular.to.navigate('/');

          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.creditCard),
          title: Text(S.of(context).cards),
          onTap: (){
            // kiugrik a drawerből
            Modular.to.pop();
            Modular.to.navigate('/');
          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.creditCard),
          title: Text(S.of(context).categories),
          onTap: (){
            // kiugrik a drawerből
            Modular.to.pop();
            Modular.to.navigate('/');
          },
        ),
      ],
    ),
  );
}
