import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_app/functions/myPdf.dart';
import 'package:share/share.dart';
import 'package:flutter_app/myGlobals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String namec, email, password, url, phoneNumber, calories;
  bool visibleDetails = false;
  bool visibleHadbara = false;
  bool visibleHashkaia = false;
  bool visibleTeura = false;

  final formKeyGlobal = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();
  void onPressed() {
    var form = formKeyGlobal.currentState;
    form.save();
  }

  bool teuraCheck = false;

  var _hadbaraChecks = [
    'קמחון',
    'אקריות',
    'כנימות',
    'קונפידור (מנות)',
    'קונפידור',
    'ראונדאפ',
    'סטרטר',
    'מתזון',
    'ברזל(מנות)',
    'תלתנים',
    'מקסגארד',
    'דורסבן'
  ];
  
  double wDetail = 0;
  double hDetail = 0;
  double wHadbara = 0;
  double hHadbara = 0;
  double wTeura = 0;
  double hTeura = 0;
  double hHashkaia = 200;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTextField(name, controller) {
    return Column(children: <Widget>[
      TextFormField(
        cursorColor: primeGreenColor,
        decoration: InputDecoration(
            labelText: name, labelStyle: TextStyle(color: primeGreenColor)),
        validator: (String value) {
          if (value.isEmpty) {
            return 'יש למלא';
          }
          return null;
        },
        controller: controller,
        onSaved: (String value) {
          namec = value;
        },
      )
    ]);
  }

  Widget _buildCheckbox(int checkNumber) {
    return SingleChildScrollView(
      child: Row(children: <Widget>[
        Checkbox(
            value: checkArr[checkNumber],
            onChanged: (bool value) {
              setState(() {
                checkArr[checkNumber] = value;
              });
            }),
        Text(_hadbaraChecks[checkNumber])
      ]),
    );
  }

  Widget _myCell(controller) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'הכנס', labelStyle: TextStyle(color: primeGreenColor)),
        validator: (String value) {
          if (value.isEmpty) {
            return 'יש למלא';
          }
          return null;
        },
        controller: controller,
        onSaved: (String value) {
          email = value;
        },
      ),
    );
  }

  int i = 1;
  Iterable<DataRow> mapLinesToDataRows(List<MyRow> rows) {
    Iterable<DataRow> dataRows = rows.map((row) {
      return DataRow(cells: [
        DataCell(Text('קו ' + row.i.toString())),
        DataCell(_myCell(row.hashkaiaController1)),
        DataCell(_myCell(row.hashkaiaController2)),
        DataCell(_myCell(row.hashkaiaController3)),
        DataCell(_myCell(row.hashkaiaController4)),
      ]);
    });
    return dataRows;
  }

  Widget _buildHashkaiaTable() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    rows.removeLast();
                                    i--;
                                    hHashkaia -= 50;
                                  });
                                }),
                            IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    rows.add(MyRow(i));
                                    i++;
                                    hHashkaia += 50;
                                  });
                                }),
                          ],
                        ),
                      ),
                      DataColumn(label: Text('אזור מושקה')),
                      DataColumn(label: Text('ימי השקייה')),
                      DataColumn(label: Text('משך השקייה')),
                      DataColumn(label: Text('זמן פתיחה')),
                    ],
                    // rows: <DataRow>[
                    rows: mapLinesToDataRows(rows).toList()),
              ],
            ),
          )),
    );
  }

  Widget _buildTeura() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            //SingleChildScrollView(child: teuraBtn()),
            // Row(
            //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Text('בדיקת תאורת גינה:'),
            //       Checkbox(
            //           value: teuraCheck,
            //           onChanged: (bool value) {
            //             setState(() {
            //               teuraCheck = value;
            //             });
            //           }),
            //     ]),
            _buildTextField('החלפת מנורה לעמוד (יח\')', teuraController1),
            _buildTextField(' מחברי חשמל (יח\')', teuraController2),
            _buildTextField('החלפת מנורה לספוט (יח\')', teuraController3),
            _buildTextField('  כבל חשמל (מ"א) ', teuraController4),
          ],
        ),
      ),
    );
  }

  Widget _buildHadbara() {
    int i = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //SingleChildScrollView(child: hadbaraBtn()),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCheckbox(i++),
              _buildCheckbox(i++),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTosafot() {
    return TextFormField(
      cursorColor: primeGreenColor,
      decoration: InputDecoration(
          labelText: 'תוספות מיוחדות',
          labelStyle: TextStyle(color: primeGreenColor),
          contentPadding: EdgeInsets.fromLTRB(125, 0, 0, 0)),
      textAlign: TextAlign.end,
      onSaved: (String value) {
        namec = value;
      },
    );
  }

  String timetext = 'תחילת עבודה';

  Future<bool> saveStartTime(String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("time", time);
    return prefs.commit();
  }

  Future<String> getStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String time = prefs.getString("time");

    return time;
  }

  @override
  void initState() {
    getStartTime().then(_updateTime);
    super.initState();
  }

  void _updateTime(String time) {
    setState(() {
      timetext = time;
      startTimeController = time;
    });
  }

  Widget _buildStartTime() {
    void dataChange() {
      intl.DateFormat hoursFormat = intl.DateFormat("HH:mm");
      String hours = hoursFormat.format(DateTime.now());
      saveStartTime(hours);
      setState(() {
        timetext = hours;
        startTimeController = hours;
      });
    }

    return RaisedButton.icon(
      label: Text(
        timetext == "תחילת עבודה".split('').reversed.join('')
            ? "$timetext".split('').reversed.join('')
            : "$timetext",
        style: TextStyle(color: primeGreenColor, fontSize: 25),
      ),
      onPressed: dataChange,
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      icon: Icon(Icons.timelapse_outlined, color: primeGreenColor),
    );
  }

  int _state = 0;
  Widget _buildPdf(context) {
    return MaterialButton(
        onPressed: () async {
          setState(() {
            if (_state == 0) {
              animateButton();
            }
          });

          intl.DateFormat hoursFormat = intl.DateFormat("HH:mm");
          String hours = hoursFormat.format(DateTime.now());
          endTimeController = hours;

          intl.DateFormat dayFormat = intl.DateFormat("dd/MM/yy");
          String day = dayFormat.format(DateTime.now());
          dayController = day;

          MyPdf my = MyPdf();
          String path = await my.generateAndPrintArabicPdf(context);
          Share.shareFiles(['$path'], text: 'Your PDF!');
          saveStartTime(
            'תחילת עבודה',
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: setUpButtonChild(),
        color: Colors.orange[200]);
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        _state = 2;
      });
    });
  }

  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        'pdf צור ושתף',
        style: TextStyle(color: primeGreenColor, fontSize: 20),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primeGreenColor),
      );
    } else {
      return Icon(Icons.check, color: primeGreenColor);
    }
  }

  Widget detailsBtn() {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: FlatButton.icon(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: visibleDetails ? primeGreenColor : secondOrangeColor,
          label: Text(
            "פרטי לקוח",
            style: TextStyle(
                color: visibleDetails ? secondOrangeColor : primeGreenColor,
                fontSize: 20),
          ),
          icon: Icon(
            Icons.account_box,
            color: visibleDetails ? secondOrangeColor : primeGreenColor,
          ),
          onPressed: () {
            if (visibleDetails) {
              wDetail = 0;
              hDetail = 0;
            } else {
              wDetail = 300;
              hDetail = 400;
            }
            setState(() {
              visibleDetails = !visibleDetails;
            });
          }),
    );
  }

  Widget hadbaraBtn() {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: FlatButton.icon(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: visibleHadbara ? primeGreenColor : secondOrangeColor,
          padding: EdgeInsets.symmetric(horizontal: 135, vertical: 20),
          label: Text(
            "הדברה",
            style: TextStyle(
                color: visibleHadbara ? secondOrangeColor : primeGreenColor,
                fontSize: 20),
          ),
          icon: Icon(
            Icons.adb,
            color: visibleHadbara ? secondOrangeColor : primeGreenColor,
          ),
          onPressed: () {
            if (visibleHadbara) {
              wHadbara = 0;
              hHadbara = 0;
            } else {
              wHadbara = 500;
              hHadbara = 500;
            }
            setState(() {
              visibleHadbara = !visibleHadbara;
            });
          }),
    );
  }

  Widget hashkaiaBtn() {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: FlatButton.icon(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          color: visibleHashkaia ? primeGreenColor : secondOrangeColor,
          padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
          label: Text(
            "השקייה",
            style: TextStyle(
                color: visibleHashkaia ? secondOrangeColor : primeGreenColor,
                fontSize: 20),
          ),
          icon: Icon(Icons.water_damage,
              color: visibleHashkaia ? secondOrangeColor : primeGreenColor),
          onPressed: () {
            setState(() {
              visibleHashkaia = !visibleHashkaia;
            });
          }),
    );
  }

  Widget teuraBtn() {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: FlatButton.icon(
          color: visibleTeura ? primeGreenColor : secondOrangeColor,
          padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
          icon: Icon(Icons.lightbulb,
              color: visibleTeura ? secondOrangeColor : primeGreenColor),
          label: Text(
            "תאורה",
            style: TextStyle(
                color: visibleTeura ? secondOrangeColor : primeGreenColor,
                fontSize: 20),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            if (visibleTeura) {
              wTeura = 0;
              hTeura = 0;
            } else {
              wTeura = 300;
              hTeura = 350;
            }
            setState(() {
              visibleTeura = !visibleTeura;
            });
          }),
    );
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: null,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(35),
          ),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.transparent,
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu), onPressed: null),
            Text(
              'דוח טיפולים',
              style: TextStyle(fontSize: 30, color: primeGreenColor),
            ),
            IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
          ],
        ),
      ),
    );
    //preferredSize: Size.fromHeight(10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: secondOrangeColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 35),
                _getCustomAppBar(),
                SizedBox(height: 15),
                _buildStartTime(),
                SizedBox(height: 40),
                Divider(
                  color: primeGreenColor,
                  endIndent: 30,
                  indent: 30,
                ),
                detailsBtn(),
                Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 900),
                      transform: null,
                      curve: Curves.linear,
                      height: hDetail,
                      width: wDetail,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          _buildTextField('שם משפחה', nameController),
                          _buildTextField('צוות', teamController),
                          _buildTextField('כתובת', addressController),
                          _buildTextField('סוג טיפול', sugTipulController),
                          _buildTextField(
                              'זמן מוקצב לטיפול', zmanTipulController),
                          _buildTextField(
                              'דגשים לטיפול', dgeshimTipulController),
                        ]),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: primeGreenColor,
                  endIndent: 30,
                  indent: 30,
                ),
                Column(
                  children: [
                    AnimatedCrossFade(
                      crossFadeState: !visibleHadbara
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 900),
                      firstChild: Container(
                        child: hadbaraBtn(),
                      ),
                      secondChild: Container(
                        child: Column(
                          children: [hadbaraBtn(), _buildHadbara()],
                        ),
                        height: 400,
                        width: 500,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: primeGreenColor,
                  endIndent: 30,
                  indent: 30,
                ),
                Column(
                  children: [
                    AnimatedCrossFade(
                      crossFadeState: !visibleHashkaia
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 900),
                      firstChild: Container(
                        child: hashkaiaBtn(),
                      ),
                      secondChild: Container(
                        child: Column(
                          children: [hashkaiaBtn(), _buildHashkaiaTable()],
                        ),
                        height: hHashkaia,
                        width: 500,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: primeGreenColor,
                  endIndent: 30,
                  indent: 30,
                ),
                teuraBtn(),
                Column(
                  children: [
                    AnimatedCrossFade(
                      crossFadeState: !visibleTeura
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(seconds: 1),
                      firstChild: Container(
                        child: null,
                      ),
                      secondChild: Container(
                        child: _buildTeura(),
                        height: 400,
                        width: 500,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: primeGreenColor,
                  endIndent: 30,
                  indent: 30,
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: [
                      _buildTosafot(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                _buildPdf(context),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

// Widget _buildBakashot() {
//   return TextFormField(
//     cursorColor: primeGreenColor,
//     decoration: InputDecoration(
//         labelText: 'בקשות מיוחדות',
//         labelStyle: TextStyle(color: primeGreenColor),
//         contentPadding: EdgeInsets.fromLTRB(125, 0, 0, 0)),
//     onSaved: (String value) {
//       namec = value;
//     },
//   );
// }
