import 'dart:io';
import 'package:flutter/cupertino.dart' as cd;
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as md;


class tableData {
  final String descriptionDetails;
  final String descriptionvalue;
  var now = new DateTime.now();
   tableData({required this.descriptionDetails, required this.descriptionvalue}){}
}

class PdfApi {

  static Future<File> generateCenteredText(String principal, String interest, String tenureValue, String Result) async {
    final pdf = Document();
    final headers = ['Description', 'Values'];
    final imageJpg =
    (await rootBundle.load('assets/emi.png')).buffer.asUint8List();


    final tableDatas = [
      tableData(descriptionDetails: "Principal", descriptionvalue: principal),
      tableData(descriptionDetails: "Interest", descriptionvalue: interest),
      tableData(descriptionDetails: "Tenure", descriptionvalue: '$tenureValue months')
    ];

    final data = tableDatas.map((user) => [user.descriptionDetails,user.descriptionvalue]).toList();


    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        buildCustomHeader(),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 2 * PdfPageFormat.mm),
            Column(
                children: [
                  Image(MemoryImage(imageJpg),height: 90,width: 120),
                  SizedBox(width: 40),
                  Text('   Emi Calculator'),

                ]
            ),
            SizedBox(width: 100 * PdfPageFormat.mm),
            // SizedBox(height: 1 * PdfPageFormat.mm),
            Column(
                children: [
                  Text(
                    Jiffy().format('MMM do yyyy'),
                    style: TextStyle(fontSize: 10,),
                  ),
                  SizedBox(height: 2 * PdfPageFormat.mm),
                  Text(
                    Jiffy().format('h:mm a'),
                    style: TextStyle(fontSize: 10,),
                  ),
                ]
            ),
          ],
        ),
        SizedBox(height: 80),
        Center(
          child: Table.fromTextArray(
            headers: headers,
            data: data,
          )
        ),
        Divider(),
      Container(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Spacer(flex: 6),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  buildText(
                    title: 'Monthly Emi',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    value: Result,
                    unite: true,
                  ),
                  SizedBox(height: 2 * PdfPageFormat.mm),
                  Container(height: 1, color: PdfColors.grey400),
                  SizedBox(height: 0.5 * PdfPageFormat.mm),
                  Container(height: 1, color: PdfColors.grey400),
                ],
              ),
            ),
          ],
        ),
      ),
      ],
      footer: (context) => buildFooter(),
    ));

    return saveDocument(name: 'summary.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static buildCustomHeader() => Container(
    padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 2,)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Summary',style: TextStyle(fontSize: 25))

      ],
    ),
  );

  static Widget buildTitle() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 2 * PdfPageFormat.mm),
      Column(
        children: [
          Text('Emi Calculator'),
        ]
      ),
      SizedBox(width: 115 * PdfPageFormat.mm),
      // SizedBox(height: 1 * PdfPageFormat.mm),
      Column(
          children: [
            Text(
              Jiffy().format('MMM do yyyy'),
              style: TextStyle(fontSize: 10,),
            ),
            SizedBox(height: 2 * PdfPageFormat.mm),
            Text(
              Jiffy().format('h:mm a'),
              style: TextStyle(fontSize: 10,),
            ),
          ]
      ),
    ],
  );

  static Widget buildFooter() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: 'Address', value: 'Chennai,Tamil Nadu'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'Paypal', value: 'krishnalatency@okicici'),
    ],
  );
  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static Widget buildTotal(Result) {

    var Result;
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                buildText(
                  title: 'Your Monthly Emi',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '$Result',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }


}