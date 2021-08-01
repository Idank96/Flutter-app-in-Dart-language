import 'dart:io';
//import 'package:flutter/cupertino.dart' as cp;
//import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_app/functions/otherPdf.dart';
import 'package:flutter_app/pages/form_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_app/myGlobals.dart';

class MyPdf extends FormScreen {
  Future<String> generateAndPrintArabicPdf(context) async {
    final pw.Document pdf = pw.Document();
    //List pdfRows = FormScreenState().rows;
    var _hadbaraChecks = [
      'קמחון',
      'אקריות',
      'כנימות',
      ' קונפידור )מנות( ',
      'קונפידור',
      'ראונדאפ',
      'סטרטר',
      'מתזון',
      ' ברזל )מנות( ',
      'תלתנים',
      'מקסגארד',
      'דורסבן'
    ];

    pw.Widget _myChecks() {
      bool tocreate = false;
      String temptext = '';
      for (int i = 0; i < 12; i++) {
        if (checkArr[i] == true) {
          tocreate = true;
          temptext += ', ' + _hadbaraChecks[i].split('').reversed.join('');
        }
      }
      try {
        temptext = temptext.substring(1, temptext.length);
      } catch (e) {
        print(e.toString());
      }
      if (tocreate) {
        return pw.Column(
            //mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(temptext,
                    style: pw.TextStyle(
                      fontSize: 12,
                    )),
                pw.Text('הדברה: '.split('').reversed.join(''),
                    style: pw.TextStyle(
                      fontSize: 15,
                    )),
              ])
            ]);
      }
      return pw.Text(temptext,
          style: pw.TextStyle(
            fontSize: 12,
          ));
    }

    pw.Widget textToPrint(text, controller) {
      String controllertext = (controller != null) ? controller : '';
      return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
        pw.Text((text + controllertext).split('').reversed.join(''),
            style: pw.TextStyle(
              fontSize: 20,
            )),
      ]);
    }

    pw.Widget printHashkaia() {
      // String controllertext = '';

      for (int i = 0; i < rows.length; i++) {
        // controllertext += 'קו ' +
        //     (i + 1).toString() +
        //     ' - ' +
        //     '       ' +
        //     rows[i].hashkaiaController1.text +
        //     '       ' +
        //     rows[i].hashkaiaController2.text +
        //     '       ' +
        //     rows[i].hashkaiaController3.text +
        //     '       ' +
        //     rows[i].hashkaiaController4.text +
        //     '\n';
      }
      // return pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
      //   pw.Directionality(
      //       textDirection: pw.TextDirection.rtl,
      //       child: pw.Center(
      //           child: pw.Text(controllertext.split('').reversed.join(''),
      //               style: pw.TextStyle(
      //                 fontSize: 10,
      //               )))),
      // ]);
      List<List<String>> tablerows = new List();
      tablerows.add(<String>[
        'זמן פתיחה'.split('').reversed.join(''),
        'משך השקייה'.split('').reversed.join(''),
        'ימי השקייה'.split('').reversed.join(''),
        'אזור מושקה'.split('').reversed.join(''),
        ' ',
      ]);

      for (var i = 0; i < rows.length; i++) {
        List<String> recind = <String>[
          rows[i].hashkaiaController4.text.split('').reversed.join(''),
          rows[i].hashkaiaController3.text.split('').reversed.join(''),
          rows[i].hashkaiaController2.text.split('').reversed.join(''),
          rows[i].hashkaiaController1.text.split('').reversed.join(''),
          ('קו ' + (i + 1).toString()).split('').reversed.join('')
        ];
        tablerows.add(recind);
      }

      return pw.Table.fromTextArray(
          cellAlignment: pw.Alignment.center, data: tablerows);
    }

    double textsize = 15.0;

    var hebrewFont =
        pw.Font.ttf(await rootBundle.load("lib/assets/static/Rubik-Light.ttf"));
    pdf.addPage(pw.Page(
        theme: pw.ThemeData.withFont(base: hebrewFont),
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Container(
              padding: pw.EdgeInsets.all(35.0),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Directionality(
                          textDirection: pw.TextDirection.rtl,
                          child: pw.Center(
                              child: pw.Text(
                                  startTimeController +
                                      '-' +
                                      endTimeController +
                                      '  ' +
                                      dayController,
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  )))),
                    ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Directionality(
                              textDirection: pw.TextDirection.rtl,
                              child: pw.Center(
                                  child: pw.Text('םילופיט ח\'\'וד',
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                      )))),
                        ]),
                    pw.SizedBox(height: 30.0),
                    pw.Container(
                      //alignment: pw.Alignment,
                      //decoration: pw.BoxDecoration(color: lightGreen, borderRadius: 100.0),
                      child: pw.Column(children: [
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          'שם משפחה: ${nameController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                        pw.SizedBox(height: 10.0),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          ' צוות: ${teamController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                        pw.SizedBox(height: 10.0),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          ' כתובת: ${addressController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                        pw.SizedBox(height: 10.0),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          'סוג טיפול: ${sugTipulController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                        pw.SizedBox(height: 10.0),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          ' זמן טיפול: ${zmanTipulController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                        pw.SizedBox(height: 10.0),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Directionality(
                                  textDirection: pw.TextDirection.rtl,
                                  child: pw.Center(
                                      child: pw.Text(
                                          ' דגשים לטיפול: ${dgeshimTipulController.text}'
                                              .split('')
                                              .reversed
                                              .join(''),
                                          style: pw.TextStyle(
                                            fontSize: textsize,
                                          )))),
                            ]),
                      ]),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.0),
                    _myChecks(),
                    pw.SizedBox(height: 20.0),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text('קווי השקייה: '.split('').reversed.join(''),
                              style: pw.TextStyle(
                                fontSize: 20,
                              )),
                        ]),
                    printHashkaia(),
                    pw.SizedBox(height: 10.0),
                    textToPrint('החלפת מנורה לעמוד: ', teuraController1.text),
                    pw.SizedBox(height: 10.0),
                    textToPrint('מחברי חשמל )יח\'(: ', teuraController2.text),
                    pw.SizedBox(height: 10.0),
                    textToPrint(
                        'החלפת מנורה לספוט )יח\'(: ', teuraController3.text),
                    pw.SizedBox(height: 10.0),
                    textToPrint('כבל חשמל )מ\'\'א\'(: ', teuraController4.text),
                  ]));
        }));
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/7.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    return path;
  }
}
