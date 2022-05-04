import 'package:mca_new_design/template/base/template.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DefaultDatatable extends StatefulWidget {
  List<String> headNames;
  List<List> bodyNames;
  List<double?>? bodyWidths;
  int freezedColNumber;
  int freezedRowNumber;
  double headNamesHorizontalPadding;
  List<int?>? bodyTextMaxlines;
  List<VoidCallback>? onTaps;
  List<bool>?
      isNumericCols; //TODO: Need to change rectangle 15 for isNumeric alignment!
  double headNamesHeight;
  Color bodyBgColor;

  DefaultDatatable({
    required this.headNames,
    required this.bodyNames,
    this.bodyWidths,
    this.bodyTextMaxlines,
    this.onTaps,
    this.isNumericCols,
    this.freezedColNumber = 0,
    this.freezedRowNumber = 0,
    this.headNamesHorizontalPadding = 0,
    this.bodyBgColor = ThemeColors.white,
    this.headNamesHeight = 60,
  }) {
    if (bodyWidths == null) {
      bodyWidths = [];
      for (int i = 0; i < headNames.length; i++) {
        bodyWidths!.add(null);
      }
    } else {
      for (int i = bodyWidths!.length; i < headNames.length; i++) {
        bodyWidths!.add(null);
      }
    }

    if (isNumericCols == null) {
      isNumericCols = [];
      for (int i = 0; i < headNames.length; i++) {
        isNumericCols!.add(false);
      }
    } else {
      for (int i = isNumericCols!.length; i < headNames.length; i++) {
        isNumericCols!.add(false);
      }
    }

    if (bodyTextMaxlines == null) {
      bodyTextMaxlines = [];
      for (int i = 0; i < headNames.length; i++) {
        bodyTextMaxlines!.add(null);
      }
    } else {
      for (int i = bodyTextMaxlines!.length; i < headNames.length; i++) {
        bodyTextMaxlines!.add(null);
      }
    }
  }

  @override
  State<DefaultDatatable> createState() => _DefaultDatatableState();
}

class _DefaultDatatableState extends State<DefaultDatatable> {
  late List<String> headNames;
  late List<List> bodyNames;
  late DataSource _dataSource;

  @override
  void initState() {
    super.initState();
    headNames = widget.headNames;
    bodyNames = widget.bodyNames;
    _dataSource = DataSource(bodyNames,
        onTaps: widget.onTaps,
        bodyTextMaxlines: widget.bodyTextMaxlines,
        isNumericCols: widget.isNumericCols,
        bodyBgColor: widget.bodyBgColor);
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
        headerGridLinesVisibility: GridLinesVisibility.none,
        gridLinesVisibility: GridLinesVisibility.none,
        columnWidthMode: ColumnWidthMode.fill,
        // stackedHeaderRows: [
        //   StackedHeaderRow(cells: [
        //     StackedHeaderCell(
        //         child: Container(width: 100, height: 20, color: Colors.red),
        //         columnNames: ['Container'])
        //   ])
        // ],
        source: _dataSource,
        frozenColumnsCount: widget.freezedColNumber,
        frozenRowsCount: widget.freezedRowNumber,
        headerRowHeight: widget.headNamesHeight.h,
        rowHeight: 35.h,
        columns: _buildColumns());
  }

  List<GridColumn> _buildColumns() {
    List<GridColumn> list = [];
    for (var element in headNames) {
      int index = headNames.indexOf(element);
      list.add(
        GridColumn(
            columnName: element,
            width: widget.bodyWidths![index] == null
                ? double.nan
                : widget.bodyWidths![index]!.w,
            columnWidthMode: ColumnWidthMode.fitByColumnName,
            label: RectangleFrame15(
              borderRadius: 0,
              height: widget.headNamesHeight,
              bgColor: ThemeColors.white,
              withBottomBorder: true,
              child: SizedText(
                textAlign: widget.isNumericCols![headNames.indexOf(element)]
                    ? TextAlign.right
                    : TextAlign.left,
                maxLines: 4,
                // width: widget.bodyWidths![index] == null
                //     ? null
                //     : widget.bodyWidths![index]!.w,
                textStyle:
                    ThemeTextRegular.xs.copyWith(color: ThemeColors.c9E9FA5),
                text: element,
              ),
            )),
      );
    }

    return list;
  }
}

class DataSource extends DataGridSource {
  List<int?>? bodyTextMaxlines;
  List<bool>? isNumericCols;
  late List<DataGridRow> dataGridRows;
  Color bodyBgColor;
  List<VoidCallback>? onTaps;

  DataSource(List<List> data,
      {this.bodyTextMaxlines,
      this.isNumericCols,
      this.onTaps,
      this.bodyBgColor = ThemeColors.white}) {
    _buildHeads(List dataGridRow) {
      List<DataGridCell<dynamic>> list = [];
      for (var element in dataGridRow) {
        list.add(DataGridCell(
            columnName: element.toString(), value: element.toString()));
      }
      return list;
    }

    dataGridRows = data
        .map<DataGridRow>(
            (dataGridRow) => DataGridRow(cells: _buildHeads(dataGridRow)))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      int rowIndex = dataGridRows.indexOf(row);
      final num? isNumber = num.tryParse(dataGridCell.value);
      final bool isRed = isNumber != null ? isNumber < 0 : false;
      return RectangleFrame15(
        borderRadius: 0,
        onTap: onTaps != null ? onTaps![rowIndex] : null,
        bgColor: rowIndex.isEven ? ThemeColors.cF2F2F2 : bodyBgColor,
        withBottomBorder: true,
        child: SizedText(
          text: dataGridCell.value.toString(),
          textStyle: ThemeTextRegular.xs
              .copyWith(color: isRed ? ThemeColors.mainRed : ThemeColors.gray),
          overflow: TextOverflow.visible,
          //textAlign:
          //                 isNumericCols![index] ? TextAlign.right : TextAlign.left
        ),
      );
    }).toList());
  }
}
