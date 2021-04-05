import 'package:flutter/material.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';

//#011f4b • #03396c • #005b96 • #6497b1 • #b3cde0
final HexColor kColorPrimary = HexColor("#2ab7ca");
final HexColor kColorPrimaryDark = HexColor("#03396c");
final HexColor kColorPrimaryLight = HexColor("#6497b1");
final HexColor kColorBlack = HexColor("#000000");
final HexColor kColorBlack2 = HexColor("#333333");
final HexColor kColorBlack_30 = HexColor("#4D000000");
final HexColor kColorWhite = HexColor("#FFFFFF");
final HexColor kColorGray1 = HexColor("#999999");
final HexColor kColorGray1_50 = HexColor("#80999999");
final HexColor kColorGray1_70 = HexColor("#B3999999");
final HexColor kColorGray2 = HexColor("#F8F8F8");
final HexColor kColorGray3 = HexColor("#F4F4F4");
final HexColor kColorGray4 = HexColor("#666666");
final HexColor kColorGray4_40 = HexColor("#66666666");
final HexColor kColorGray5 = HexColor("#C1C1C1");
final HexColor kColorGray6 = HexColor("#707070");
final HexColor kColorGray7 = HexColor("#DDDDDD");

final HexColor kColorGoogleBtn = HexColor("#FFF1F0");
final HexColor kColorGoogleBorderBtn = HexColor("#F14336");
final HexColor kColorFacebookBtn = HexColor("#F5F9FF");
final HexColor kColorFacebookBorderBtn = HexColor("#3164CE");

const kListColorPriority = [
  Colors.red,
  Colors.orange,
  Colors.blue,
  Colors.blueGrey
];

const MaterialColor kColorStatusBar = MaterialColor(0x03396c, {});

const String keyListColorLabel = 'label';
const String keyListColorColor = 'color';
const String keyListColorValue = 'value';

const List<Map<String, Object>> kListColorDefault = [
  {
    "label": "Grey",
    "color": Color.fromARGB(255, 184, 184, 184),
    "value": "grey"
  },
  {
    "label": "Berry Red",
    "color": Color.fromARGB(255, 184, 37, 95),
    "value": "berry-red"
  },
  {"label": "Red", "color": Color.fromARGB(255, 219, 64, 53), "value": "red"},
  {
    "label": "Orange",
    "color": Color.fromARGB(255, 255, 153, 51),
    "value": "orange"
  },
  {
    "label": "Yellow",
    "color": Color.fromARGB(255, 250, 208, 0),
    "value": "yellow"
  },
  {
    "label": "Olive Green",
    "color": Color.fromARGB(255, 175, 184, 59),
    "value": "olive-green"
  },
  {
    "label": "Lime Green",
    "color": Color.fromARGB(255, 126, 204, 73),
    "value": "lime-green"
  },
  {
    "label": "Green",
    "color": Color.fromARGB(255, 41, 148, 56),
    "value": "green"
  },
  {
    "label": "Mint Green",
    "color": Color.fromARGB(255, 106, 204, 188),
    "value": "mint-green"
  },
  {
    "label": "Teal",
    "color": Color.fromARGB(255, 21, 143, 173),
    "value": "teal"
  },
  {
    "label": "Sky Blue",
    "color": Color.fromARGB(255, 20, 170, 245),
    "value": "sky-blue"
  },
  {
    "label": "Light Blue",
    "color": Color.fromARGB(255, 150, 195, 235),
    "value": "light-blue"
  },
  {
    "label": "Blue",
    "color": Color.fromARGB(255, 64, 115, 255),
    "value": "blue"
  },
  {
    "label": "Grape",
    "color": Color.fromARGB(255, 136, 77, 255),
    "value": "grape"
  },
  {
    "label": "Violet",
    "color": Color.fromARGB(255, 175, 56, 235),
    "value": "violet"
  },
  {
    "label": "Lavender",
    "color": Color.fromARGB(255, 235, 150, 235),
    "value": "lavender"
  },
  {
    "label": "Magenta",
    "color": Color.fromARGB(255, 224, 81, 148),
    "value": "magenta"
  },
  {
    "label": "Salmon",
    "color": Color.fromARGB(255, 255, 141, 133),
    "value": "salmon"
  },
  {
    "label": "Charcoal",
    "color": Color.fromARGB(255, 128, 128, 128),
    "value": "charcoal"
  },
  {
    "label": "Taupe",
    "color": Color.fromARGB(255, 204, 172, 147),
    "value": "taupe"
  },
  {
    "label": "Dark",
    "color": Color.fromARGB(255, 44, 43, 53),
    "value": "dark",
  }
];
