// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:duszamobile2021/chart_helper.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/indicator.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/exporter.dart';
import 'package:duszamobile2021/statistics/balance_changes_char.dart';
import 'package:duszamobile2021/statistics/money_chart.dart';
import 'package:duszamobile2021/statistics/spending_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class StatisticsTab extends StatelessWidget {
  final Account account;
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  StatisticsTab({Key? key})
      : account = Modular.get<AccountRepository>().getAccount(),
        super(key: key);

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  void _shareData() async {
    List<ExportItem> exportItems = createExportItems(account);
    List<String> filelines = [ExportItem.headerLine];
    for (var element in exportItems) {
      filelines.add(element.line);
    }
    String fileContent = filelines.join('\n');
    Share.share(fileContent);
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = flattenCategories(account.categories);
    Map<String, Color> categoryColors = {};
    for (var category in categories) {
      categoryColors[category] =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    }
    Map<String, Color> balanceColors = {};
    for (var balance in account.balances) {
      balanceColors[balance.id] =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    }

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.save,
        activeIcon: Icons.close,
        activeLabel: Text(S.of(context).cancel),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.print),
            label: S.of(context).printStatistics,
            onTap: () {
              _printScreen();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.import_export),
            label: S.of(context).exportData,
            onTap: () {
              _shareData();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _printKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    S.of(context).accountMoneyHistory,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              MoneyChart(
                account: account,
                colorMap: balanceColors,
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "_SPENDINGSTHISMONTH",
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              SpendingChart(
                account: account,
                categoryColorMap: categoryColors,
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "_COMPARISONPERBALANCE",
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 20.0),
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              BalanceChangesChart(
                account: account,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
