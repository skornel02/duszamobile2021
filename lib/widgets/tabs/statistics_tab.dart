import 'package:duszamobile2021/chart_helper.dart';
import 'package:duszamobile2021/generated/l10n.dart';
import 'package:duszamobile2021/repositories/account_repository.dart';
import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/exporter.dart';
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
    exportItems.forEach((element) {
      filelines.add(element.line);
    });
    String fileContent = filelines.join('\n');
    Share.share(fileContent);
  }

  @override
  Widget build(BuildContext context) {
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
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.print),
      //   onPressed: _printScreen,
      // ),
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
              SizedBox(
                height: 240,
                child: AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18.0,
                        left: 12.0,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(
                        moneyChangeData(context, account),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
