import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:snosey_flutter_package/SnoseyFlutterPackage.dart';
import 'package:snosey_flutter_package/dashboard/table/SnoseyTable.dart';

class SnoseyConvertTableModel {
  final String name;
  final List<String> cells;

  SnoseyConvertTableModel(this.name, this.cells);
}

class SnoseyTableConverter {
  List<List<String>> dataRowList = [];
  List<String> headerList = [];

  mapData(
      List<SnoseyTableData> customTableMapList, Set<int> printDataList) async {
    var list = customTableMapList.reversed
        .where((element) => element.printTableModel != null);
    if (list.isEmpty) return;
    headerList = list.map((e) => e.printTableModel!.name).toList();

    int rowCount = printDataList.isNotEmpty
        ? printDataList.length
        : list.first.printTableModel!.cells.length;

    if (printDataList.isEmpty)
      for (int i = 0; i < rowCount; i++) {
        dataRowList.add(list.map((e) => e.printTableModel!.cells[i]).toList());
      }
    else {
      printDataList.forEach((index) {
        dataRowList
            .add(list.map((e) => e.printTableModel!.cells[index]).toList());
      });
    }
  }

  tableToPDF(String title) async {
    ByteData font;
    Font ttf;
    Document pdf;
    font = await rootBundle.load(SnoseyFlutterPackage.defaultFontPath);
    ttf = Font.ttf(font);
    pdf = pw.Document();
    pdf.addPage(
      MultiPage(
        build: (context) {
          return [
            Directionality(
              textDirection: TextDirection.rtl, //TODO
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(title, style: TextStyle(font: ttf, fontSize: 25)),
                    Table.fromTextArray(
                      context: context,
                      data: [headerList, ...dataRowList],
                      cellStyle: TextStyle(
                        font: ttf,
                        fontSize: 17,
                      ),
                      cellAlignment: Alignment.center,
                      headerAlignment: Alignment.center,
                      headerStyle: TextStyle(font: ttf, fontSize: 20),
                    ),
                  ]),
            ),
          ];
        },
      ),
    );
    pdf.save().then((value) async {
      await Printing.layoutPdf(onLayout: (_) => value);
    });
  }

  tableToExcel(String title) async {
    var excel =
        Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
    excel.rename(excel.sheets.values.first.sheetName, title);
    var extraSpace = "            ";
    /*   font = await rootBundle.load("assets/fonts/Cairo-SemiBold.ttf");
    ttf = Font.ttf(font);
 */
    CellStyle colStyle = CellStyle(
      backgroundColorHex: "#000000",
      //TODO
      fontColorHex: "#ffffff",
      //TODO
      fontSize: 25,
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

    var sheet = excel.sheets[title];
    CellStyle rowStyle = CellStyle(
      backgroundColorHex: "#de1d41",
      //TODO
      fontColorHex: "#ffffff",
      //TODO
      fontSize: 20,
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

    ////// insert cols //////
    for (int i = 0; i < headerList.length; i++) {
      //sheet!.setColAutoFit(i);//TODO
      sheet!.updateCell(
        CellIndex.indexByColumnRow(
          rowIndex: 0,
          columnIndex: i,
        ),
        extraSpace + headerList[i] + extraSpace,
        cellStyle: colStyle,
      );
    }

    ////// insert rows //////
    for (int rowIndex = 1; rowIndex < dataRowList.length; rowIndex++) {
      for (int colIndex = 0; colIndex < headerList.length; colIndex++)
        sheet!.updateCell(
          CellIndex.indexByColumnRow(
            rowIndex: rowIndex,
            columnIndex: colIndex,
          ),
          extraSpace + dataRowList[rowIndex - 1][colIndex] + extraSpace,
          cellStyle: rowStyle,
        );
    }
    excel.save(fileName: "${DateTime.now().toString()}.xlsx");
  }
}
