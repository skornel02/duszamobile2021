import 'dart:math';

import 'package:duszamobile2021/resources/account.dart';
import 'package:duszamobile2021/resources/item.dart';
import 'package:duszamobile2021/widgets/list_items/item_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdf;

class CategoriesWidget extends StatelessWidget {
  final Account account;

  const CategoriesWidget({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          account.items.isNotEmpty
              ? SizedBox(
                  height: 240,
                  width: 360,
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        child: PieChart(
                          PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                      )),
                )
              : SizedBox(),
          ...account.categories.keys.map((category) {
            List<Item> latest = account.lastSortedItems
                .where((element) => element.category.startsWith("$category/"))
                .toList();
            List<String> subcategories = account.categories[category]!;

            return Column(
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      category,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 20.0),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 150,
                  child: AspectRatio(
                    aspectRatio: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChart(BarChartData(
                        barGroups:
                            subcategoriesForCategory(category, subcategories),
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            getTitles: (value) => subcategories[value.toInt()],
                          ),
                          topTitles: SideTitles(showTitles: false),
                          rightTitles: SideTitles(showTitles: false),
                        ),
                      )),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: min(3, latest.length),
                  itemBuilder: (context, index) {
                    return ItemWidget(item: latest[index]);
                  },
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    int totalItems = account.items.length;
    Color a = Colors.blue;
    Color b = Colors.green;
    List<PieChartSectionData> data = [];
    flattenCategories(account.categories).forEach((category) {
      List<Item> items = account.items
          .where((element) => element.category == category)
          .toList();
      if (items.isNotEmpty) {
        data.add(
          PieChartSectionData(
            value: items.length.toDouble(),
            title: category,
            radius: 50.0,
            color: Color.lerp(a, b, items.length / totalItems.toDouble()),
            titleStyle: const TextStyle(
              color: Colors.black,
              backgroundColor: Colors.grey,
            ),
            borderSide: const BorderSide(
              width: 0.3,
            ),
          ),
        );
      }
    });

    return data;
  }

  List<BarChartGroupData> subcategoriesForCategory(
    String category,
    List<String> subcategories, {
    Map<String, Color> colorMap = const {},
  }) {
    List<BarChartGroupData> data = [];
    Map<String, int> usageStatistics = {};
    account.items.forEach((item) {
      if (item.category.startsWith("$category/")) {
        String subcat = item.category.replaceFirst("$category/", "");
        if (!usageStatistics.containsKey(subcat)) {
          usageStatistics[subcat] = 0;
        }
        usageStatistics[subcat] = usageStatistics[subcat]! + 1;
      }
    });
    int x = 0;
    subcategories.forEach((subcategory) {
      int amount = usageStatistics.putIfAbsent(subcategory, () => 0);
      data.add(
        BarChartGroupData(
          x: x++,
          barRods: [
            BarChartRodData(
              y: amount.toDouble(),
              colors: [
                colorMap[subcategories] ??
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0)
              ],
            )
          ],
        ),
      );
    });
    return data;
  }
}
