import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class GenerateContract {
  //generateContract=============================================================
  static Future<Uint8List> generatePdf({
    required String pId,
    required String bloodType,
    required List diseaseList,
    required List sensitiveList,
    PdfPageFormat? format,
  }) async {
    var arabicFont = Font.ttf(
        await rootBundle.load("assets/font/DINNextLTArabic-Regular-2.ttf"));
    final pdf = Document(
        pageMode: PdfPageMode.fullscreen,
        version: PdfVersion.pdf_1_5,
        compress: false);
    pdf.addPage(
      MultiPage(

          margin:
              const EdgeInsets.only(left: 25, right: 25, bottom: 40, top: 40),
          //pageTheme: ,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          footer: (context) {
            final pages = "ص"+" "+"${context.pageNumber}"+" من "+"${context.pagesCount} ";
            return Center(
                child: Text(pages, style: const TextStyle(fontSize: 15)));
          },
          pageFormat: format,
          theme: ThemeData.withFont(
            base: arabicFont,
          ),
          textDirection: TextDirection.rtl,
          build: (context) => [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Header(
                        child: Container(
                            height: 60,
                            color: PdfColors.blue,
                            child: Center(
                              child: showText('Patient Information:'),
                            )),
                      ),
                      // showParagraph(pragraf1),
                      SizedBox(height: 30),
                      Row(

                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            showText('فصيلة الدم: '+'${bloodType}'),

                          ]),
                      SizedBox(height: 15),
                      Container(
                          height: 2,
                          width: double.infinity,
                          color: PdfColors.blueAccent),
//Medicines==========================================================================
                      SizedBox(height: 10),

                      showText('الامراض المزمنة'),
                      Container(
                          height: 2,
                          width: double.infinity,
                          color: PdfColors.blueAccent),
                      SizedBox(height: 10),
//==============================================================

                      SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: diseaseList.length,
                            itemBuilder: (context, i) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    showText('${diseaseList[i]}'),
                                    showText('')
                                  ]);
                            },
                          )),
                      Container(
                          height: 2,
                          width: double.infinity,
                          color: PdfColors.blueAccent),
                      SizedBox(height: 10),
//symptoms==========================================================================
                      SizedBox(height: 10),

                      showText('الحساسيات'),
                      Container(
                          height: 2,
                          width: double.infinity,
                          color: PdfColors.blueAccent),
                      SizedBox(height: 10),
//==============================================================

                      SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: sensitiveList.length,
                            itemBuilder: (context, i) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    showText('${sensitiveList[i]}'),
                                    showText('')
                                  ]);
                            },
                          )),
                    ])
              ]),
    );

    return pdf.save();
    //saveDocument(name: 'contract.pdf', pdf: pdf);
  }

  //Paragraph==================================================================================================
  static Widget showParagraph(String text,
      {double fontSize = 18, PdfColor color = PdfColors.black}) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Paragraph(
            text: text,
            textAlign: TextAlign.justify,
            margin: const EdgeInsets.only(bottom: 7.0 * PdfPageFormat.mm),
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                wordSpacing: 1,
                //fontBold:Font.timesBold() ,
                lineSpacing: 2)));
  }

//text==================================================================================================
  static Widget showText(String text,
      {double fontSize = 18, PdfColor color = PdfColors.black}) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Text(text,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                wordSpacing: 1,
                //fontBold:Font.timesBold() ,
                lineSpacing: 2)));
  }

  //save file in device======================================================================
  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

//save file in device======================================================================
  static Future<File> getDocumentPdf(
      {String name = 'Patien.pdf', required Uint8List bytes}) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

//==================================================
  static Future openPdf(File file) async {
    final url = file.path;
    await OpenFile.open(
      url,
    );
  }
}
