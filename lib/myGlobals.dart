library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor primeGreenColor2 = MaterialColor(0xff356859, color);

Color primeGreenColor = Color(0xff356859);
Color secondOrangeColor = Color(0xFFFFFBE6);
Color thirdOrangeColor = Color(0xffFD5523);


//info controllers
TextEditingController nameController = TextEditingController();
TextEditingController teamController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController sugTipulController = TextEditingController();
TextEditingController zmanTipulController = TextEditingController();
TextEditingController dgeshimTipulController = TextEditingController();

// light controllers
TextEditingController teuraController1 = TextEditingController();
TextEditingController teuraController2 = TextEditingController();
TextEditingController teuraController3 = TextEditingController();
TextEditingController teuraController4 = TextEditingController();

String dayController = '';
String startTimeController = '';
String endTimeController = '';

class MyRow {
  final int i;
  final TextEditingController hashkaiaController1 = TextEditingController();
  final TextEditingController hashkaiaController2 = TextEditingController();
  final TextEditingController hashkaiaController3 = TextEditingController();
  final TextEditingController hashkaiaController4 = TextEditingController();
  MyRow(this.i);
}

List<MyRow> rows = []; //empty list of rows which will expand every "+" click

List<bool> checkArr = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];
