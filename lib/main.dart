import 'package:duszamobile2021/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:monet/monet.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MonetProvider monet = await MonetProvider.newInstance();

  runApp(
    ModularApp(
      module: AppModule(),
      child: ZoldOr(
        colors: monet.getColors(Colors.green),
      ),
    ),
  );
}

class ZoldOr extends StatelessWidget {
  MonetColors colors;
  ZoldOr({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: colors.accent1.asMaterialColor,
      ),
    ).modular();
  }
}
