import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinnova/DinnovaTheme.dart';
import 'package:dinnova/api/DinnovaApiResponse.dart';
import 'package:dinnova/dashboard/table/DinnovaTableConverter.dart';
import 'package:dinnova/elements/DinnovaSearchTextField.dart';
import 'package:dinnova/utils/DinnovaEmptyResult.dart';
import 'package:dinnova/utils/DinnovaProgressLoading.dart';
import 'package:dinnova/utils/DinnovaSizes.dart';

class DinnovaTableData {
  Object? key;
  DataColumn dataColumn;
  DinnovaConvertTableModel? printTableModel;
  List<DataCell> dataCells;
  double width;

  DinnovaTableData(
      {required this.dataColumn,
      required this.dataCells,
      this.printTableModel,
      required this.key,
      this.width = 150});
}

class DinnovaTableWidget extends StatefulWidget {
  final List<DinnovaTableData> customTableMapList;
  final int? sortColumnIndex;
  final bool sortAsc;
  final VoidCallback? onAddNew;
  final DinnovaSearchTextField? searchTextField;
  final Widget? spinner;
  final VoidCallback? onFilter;
  final DinnovaPagination pagination;
  final Function(int) onPageSizeChanged;
  final Function(int) onPageNumberChanged;
  final bool isLoading;
  final String tableTitle;
  final bool showCheckbox;

  DinnovaTableWidget(
    this.customTableMapList, {
    required this.sortColumnIndex,
    required this.sortAsc,
    required this.pagination,
    required this.onPageSizeChanged,
    required this.onPageNumberChanged,
    required this.isLoading,
    this.showCheckbox = true,
    this.onAddNew,
    this.spinner,
    this.searchTextField,
    this.onFilter,
    this.tableTitle = "",
  });

  @override
  State<StatefulWidget> createState() => _DinnovaTableWidgetState();
}

class _DinnovaTableWidgetState extends State<DinnovaTableWidget> {
  late int currentPageCountValue;
  var pageSizes = [15, 50, 100];

  int maxPageItemCount = 7;

  double maxWidth = 40;

  final double columnSpacing = 0;

  late List<DataRow> dataRows;

  var scrollControllerH = ScrollController();

  var scrollControllerV = ScrollController();

  Set<int> printDataList = Set.of([]);

  addRowToExport(int index, bool isSelect) {
    setState(() {
      if (isSelect)
        printDataList.add(index);
      else
        printDataList.remove(index);
    });
  }

  @override
  void initState() {
    currentPageCountValue = widget.pagination.pageSize == 0
        ? pageSizes.first
        : widget.pagination.pageSize;
    widget.customTableMapList.forEach((element) {
      maxWidth += (element.width + columnSpacing);
      if (element.dataColumn.onSort != null) maxWidth += 18;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<DataRow> getDataTableRows() {
    List<DataRow> dataRowList = [];
    int rowCount = widget.customTableMapList.first.dataCells.length;
    for (int i = 0; i < rowCount; i++) {
      dataRowList.add(
        DataRow(
          selected: printDataList.contains(i),
          onSelectChanged: (isSelect) {
            addRowToExport(i, isSelect!);
          },
          cells: widget.customTableMapList
              .map(
                (tableCells) => DataCell(
                  Container(
                    width: tableCells.width,
                    child: Center(child: tableCells.dataCells[i].child),
                  ),
                  onDoubleTap: tableCells.dataCells[i].onDoubleTap,
                  onLongPress: tableCells.dataCells[i].onLongPress,
                  onTapCancel: tableCells.dataCells[i].onTapCancel,
                  onTapDown: tableCells.dataCells[i].onTapDown,
                  placeholder: tableCells.dataCells[i].placeholder,
                  showEditIcon: tableCells.dataCells[i].showEditIcon,
                  onTap: tableCells.dataCells[i].onTap,
                ),
              )
              .toList(),
        ),
      );
    }
    return dataRowList;
  }

  @override
  Widget build(BuildContext context) {
    dataRows = getDataTableRows();
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Card(
        margin: EdgeInsets.all(DinnovaSizes.defaultMargin),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            width: 350,
                            child: Row(
                              children: [
                                widget.onAddNew != null
                                    ? TextButton(
                                        child: Icon(Icons.add),
                                        onPressed: widget.onAddNew,
                                        style: DinnovaButtonThemes
                                                .iconButtonCircleTheme(
                                                    context: context)
                                            .style,
                                      )
                                    : Container(),
                                widget.onFilter != null
                                    ? TextButton(
                                        child: Icon(Icons.filter_list_alt),
                                        onPressed: widget.onFilter,
                                        style: DinnovaButtonThemes
                                                .iconButtonCircleTheme(
                                                    context: context)
                                            .style,
                                      )
                                    : Container(),
                                widget.searchTextField != null
                                    ? Expanded(
                                        child: widget.searchTextField!
                                            .marginSymmetric(
                                                horizontal:
                                                    DinnovaSizes.defaultMargin),
                                      )
                                    : Container(),
                              ],
                            ).marginAll(DinnovaSizes.defaultMargin),
                          ),
                          widget.spinner != null
                              ? SizedBox(
                                  width: 300,
                                  child: widget.spinner,
                                )
                              : Container(
                                  width: 0,
                                )
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  var pdfPrinter = DinnovaTableConverter();
                                  pdfPrinter.mapData(
                                    widget.customTableMapList,
                                    printDataList,
                                  );
                                  pdfPrinter.tableToPDF(widget.tableTitle);
                                },
                                icon: Icon(
                                  Icons.print,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            IconButton(
                                onPressed: () {
                                  var tableConverter = DinnovaTableConverter();
                                  tableConverter.mapData(
                                    widget.customTableMapList,
                                    printDataList,
                                  );
                                  tableConverter
                                      .tableToExcel(widget.tableTitle);
                                },
                                icon: Icon(
                                  Icons.save,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RawScrollbar(
                    controller: scrollControllerH,
                    mainAxisMargin: 5,
                    isAlwaysShown: true,
                    radius: Radius.circular(30),
                    child: SingleChildScrollView(
                      controller: scrollControllerH,
                      scrollDirection: Axis.horizontal,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            controller: scrollControllerV,
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              showBottomBorder: true,
                              showCheckboxColumn: widget.showCheckbox,
                              columnSpacing: columnSpacing,
                              border: TableBorder.all(
                                width: 1.0,
                                color: Theme.of(context).dividerColor,
                              ),
                              columns: getDataTableColumns(),
                              rows: dataRows,
                            ),
                          ),
                          Column(
                            children: [
                              Theme(
                                // to change sort icon color
                                data: Get.theme.copyWith(
                                    iconTheme: IconThemeData(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                                child: Container(
                                  color: Theme.of(context).colorScheme.primary,
                                  child: Row(
                                    children: [
                                      !widget.showCheckbox
                                          ? Container()
                                          : Container(
                                              width: 30,
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      start: 4),
                                              child: Center(
                                                child: Checkbox(
                                                    checkColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    fillColor:
                                                        MaterialStateProperty
                                                            .all(Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary),
                                                    value: () {
                                                      var length = widget
                                                          .customTableMapList
                                                          .first
                                                          .dataCells
                                                          .length;
                                                      if (length == 0)
                                                        return false;
                                                      var isCheck =
                                                          printDataList
                                                                      .length ==
                                                                  length
                                                              ? true
                                                              : printDataList
                                                                      .isEmpty
                                                                  ? false
                                                                  : null;
                                                      return isCheck;
                                                    }.call(),
                                                    tristate: true,
                                                    onChanged: (isSelect) {
                                                      setState(() {
                                                        if (isSelect == null ||
                                                            !isSelect)
                                                          printDataList.clear();
                                                        else {
                                                          for (int i = 0;
                                                              i <
                                                                  widget
                                                                      .customTableMapList
                                                                      .first
                                                                      .dataCells
                                                                      .length;
                                                              i++) {
                                                            addRowToExport(
                                                                i, isSelect);
                                                          }
                                                        }
                                                      });
                                                    }),
                                              ),
                                            ),
                                      DataTable(
                                        sortColumnIndex: widget.sortColumnIndex,
                                        sortAscending: widget.sortAsc,
                                        showCheckboxColumn: widget.showCheckbox,
                                        columnSpacing: columnSpacing,
                                        columns: getDataTableColumns(),
                                        rows: [],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 30),
                              child: ListView.builder(
                                  itemCount: maxPageItemCount,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return itemPageNumber(index);
                                  }),
                            ),
                            Text(
                              "رقم الصفحة",
                              style: Theme.of(context).textTheme.subtitle1,
                            ).marginSymmetric(
                                horizontal: DinnovaSizes.defaultMargin,
                                vertical: DinnovaSizes.defaultMargin / 2)
                          ],
                        ),
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            children: [
                              Text(
                                "عرض عدد",
                              ),
                              DropdownButton<int>(
                                value: currentPageCountValue,
                                alignment: Alignment.center,
                                items: pageSizes.map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    alignment: Alignment.center,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    currentPageCountValue = value!;
                                    widget.onPageSizeChanged(value);
                                  });
                                },
                              ).marginSymmetric(
                                  horizontal: DinnovaSizes.defaultMargin),
                              Text(
                                "عنصر في الصفحه الواحدة",
                              ),
                            ],
                          ),
                          Text(
                            "اجمالي عدد العناصر ${widget.pagination.totalCount} , عدد الصفحات ${widget.pagination.totalPages}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ).marginAll(DinnovaSizes.defaultMargin),
                    ],
                  ),
                ),
              ],
            ),
            widget.isLoading
                ? Center(child: DinnovaProgressLoading.showIndicator(context))
                : dataRows.isEmpty
                    ? DinnovaEmptyResult()
                    : Container()
          ],
        ),
      ),
    );
  }

  List<DataColumn> getDataTableColumns() {
    return widget.customTableMapList.map((customTableMap) {
      return DataColumn(
        label: Container(
          width: customTableMap.width,
          child: Center(child: customTableMap.dataColumn.label),
        ),
        numeric: customTableMap.dataColumn.numeric,
        onSort: customTableMap.dataColumn.onSort,
        tooltip: customTableMap.dataColumn.tooltip,
      );
    }).toList();
  }

  Widget itemPageNumber(int index) {
    bool isMore = false;
    bool isLess = false;
    String textValue = "";
    String threeDots = "...";

    if (widget.pagination.currentPage + maxPageItemCount <
        widget.pagination.totalPages) isMore = true;

    if (widget.pagination.currentPage - 2 > 0) isLess = true;

    if (isLess && index == 0) {
      textValue = "1";
    } else if (isLess && index == 1) {
      textValue = threeDots;
    } else if (isMore && index == maxPageItemCount - 1) {
      textValue = widget.pagination.totalPages.toString();
    } else if (isMore && index == maxPageItemCount - 2) {
      textValue = threeDots;
    } else {
      var currentPage = ((widget.pagination.totalPages <= maxPageItemCount)
              ? 1
              : widget.pagination.currentPage) +
          index;
      if (widget.pagination.currentPage == 2) currentPage--;

      if (isMore && isLess) {
        currentPage -= 2;
      } else if (isLess) {
        currentPage =
            widget.pagination.totalPages + index - maxPageItemCount + 1;
      }
      textValue = currentPage.toString();
    }

    if (textValue != threeDots) {
      var number = int.parse(textValue);
      if (number > widget.pagination.totalPages || number < 1) {
        textValue = "";
      }
    }

    if (textValue == widget.pagination.currentPage.toString()) {
      return Center(
        child: TextButton(
            onPressed: () {},
            style: DinnovaButtonThemes.iconButtonCircleTheme(context: context)
                .style,
            child: Text(textValue)),
      );
    } else {
      return Center(
        child: InkWell(
          onTap: textValue == threeDots
              ? null
              : () {
                  if (textValue != threeDots)
                    widget.onPageNumberChanged(int.parse(textValue));
                },
          child: Text(textValue),
        ).marginSymmetric(horizontal: DinnovaSizes.defaultMargin / 2),
      );
    }
  }
}
