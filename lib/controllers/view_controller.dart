
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class ViewController extends GetxController {

  var index = 0.obs;

  var homeIndex = 0.obs;

  var spotsList = <FlSpot>[].obs;

  var chartIndex = 0;

  List<Tweet> tweets = [];

  Map<int, Map<int,int>> types = {
    0: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    1: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    2: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    3: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    4: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    5: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    6: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    7: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
    8: {
      0: 0, 
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0,
      16: 0,
      17: 0,
      18: 0,
      19: 0,
      20: 0,
      21: 0,
      22: 0,
      23: 0,
    },
  };

  Map<int, List<Tweet>> categories = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
    7: [],
    8: [],
  };

  var rows = <DataRow>[].obs;

  void setRows(int i) {
    rows.value = List.generate(categories[i]!.length, (index) => DataRow(
      cells: <DataCell>[
        DataCell(SizedBox(width: 100,child: Text(
          categories[i]![index].content,
          overflow: TextOverflow.ellipsis,
        ))),
        DataCell(SizedBox(width: 80,child: Text(
          categories[i]![index].location,
          style: const TextStyle(
            height: 1.5
          ),
        ))),
        DataCell(Text(categories[i]![index].service)),
      ]
    ));
  }

  void getTypes() {
    for (var tweet in tweets) {
      var parsedDate = DateTime.parse(tweet.date);
      switch (tweet.service) {
        case 'tarjeta de crédito':
          types[0]![parsedDate.hour] = types[0]![parsedDate.hour]! + 1;
          categories[0]!.add(tweet);
          break;
        case 'tarjeta de débito':
          types[1]![parsedDate.hour] = types[1]![parsedDate.hour]! + 1;
          categories[1]!.add(tweet);
          break;
        case 'crédito':
          types[2]![parsedDate.hour] = types[2]![parsedDate.hour]! + 1;
          categories[2]!.add(tweet);
          break;
        case 'cuenta bancaria':
          types[3]![parsedDate.hour] = types[3]![parsedDate.hour]! + 1;
          categories[3]!.add(tweet);
          break;
        case 'nómina':
          types[4]![parsedDate.hour] = types[4]![parsedDate.hour]! + 1;
          categories[4]!.add(tweet);
          break;
        case 'pensión':
          types[5]![parsedDate.hour] = types[5]![parsedDate.hour]! + 1;
          categories[5]!.add(tweet);
          break;
        case 'cuenta de ahorro':
          types[6]![parsedDate.hour] = types[6]![parsedDate.hour]! + 1;
          categories[6]!.add(tweet);
          break;
        case 'seguro':
          types[7]![parsedDate.hour] = types[7]![parsedDate.hour]! + 1;
          categories[7]!.add(tweet);
          break;
        case 'invertir':
          types[8]![parsedDate.hour] = types[8]![parsedDate.hour]! + 1;
          categories[8]!.add(tweet);
          break;
        default:
      }
    }
  }

  getSpots(int index) {
    chartIndex = index;
    var type = types[index];
    List<FlSpot> spots = [];
    type!.forEach((key, value) {
      var spot = FlSpot(key.toDouble(), value.toDouble());
      spots.add(spot);
    });
    spotsList.value = spots;
  }

  List<FlSpot> get spots => spotsList.value;

}