import 'package:biznew/common_widget/widget.dart';
import 'package:biznew/screens/claim_form/claim_form_controller.dart';
import 'package:biznew/screens/claim_form/claim_model.dart';
import 'package:biznew/screens/claim_form/save_to_mobile.dart';
import 'package:biznew/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

import '../../theme/app_colors.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({Key? key}) : super(key: key);

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  Future<void> _exportDataGridToExcel() async {
    final Workbook workbook = key.currentState!.exportToExcelWorkbook();

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    await saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  Future<void> _exportDataGridToPdf() async {
    final PdfDocument document =
        key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);

    final List<int> bytes = document.saveSync();
    await saveAndLaunchFile(bytes, 'DataGrid.pdf');
    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimFormController>(builder: (cont) {
      return WillPopScope(
          onWillPop: () async {
            return cont.onWillPopBack();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: buildTextMediumWidget(
                  "Export claim", whiteColor, context, 16,
                  align: TextAlign.center),
              leading: GestureDetector(
                onTap: () {
                  cont.onWillPopBack();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                ),
              ),
            ),
            body: cont.loader == true
                ? Center(
                    child: buildCircularIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                              width: 150.0,
                              child: MaterialButton(
                                  color: approveColor,
                                  onPressed: _exportDataGridToExcel,
                                  child: const Center(
                                      child: Text(
                                    'Export to Excel',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            ),
                            const Padding(padding: EdgeInsets.all(20)),
                            SizedBox(
                              height: 40.0,
                              width: 150.0,
                              child: MaterialButton(
                                  color: errorColor,
                                  onPressed: _exportDataGridToPdf,
                                  child: const Center(
                                      child: Text(
                                    'Export to PDF',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SfDataGrid(
                          key: key,
                          source: cont.claimDataSource,
                          columnWidthMode: ColumnWidthMode.auto,
                          columns: <GridColumn>[
                            GridColumn(
                                columnName: 'ID',
                                label: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'ID',
                                    ))),
                            GridColumn(
                                columnName: 'Name',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Name'))),
                            GridColumn(
                                columnName: 'Claim Date',
                                width: 100.0,
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Claim Date',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'Amount',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Amount'))),
                            GridColumn(
                                columnName: 'Bill Date',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Bill Date'))),
                            GridColumn(
                                columnName: 'Billable',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Billable'))),
                            GridColumn(
                                columnName: 'Task Name',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Task Name'))),
                            GridColumn(
                                columnName: 'Service Name',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Service Name'))),
                            GridColumn(
                                columnName: 'Status',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Status'))),
                            GridColumn(
                                columnName: 'Particulars',
                                label: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    child: const Text('Particulars'))),
                          ],
                        ),
                      ),
                    ],
                  ),
          ));
    });
  }
}

class ClaimDataSource extends DataGridSource {
  ClaimDataSource({required List<ClaimClientListDetails> claimData}) {
    _claimData = claimData
        .map<DataGridRow>((ClaimClientListDetails e) =>
            DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                columnName: 'ID',
                value: e.claimId,
              ),
              DataGridCell<String>(
                columnName: 'Name',
                value: e.name,
              ),
              DataGridCell<String>(
                  columnName: 'Claim Date', value: e.claimDate),
              DataGridCell<String>(columnName: 'Amount', value: e.claimAmount),
              DataGridCell<String>(columnName: 'Bill Date', value: e.billDate),
              DataGridCell<String>(
                  columnName: 'Billable', value: e.cliamBillable),
              DataGridCell<String>(columnName: 'Task Name', value: e.taskName),
              DataGridCell<String>(
                  columnName: 'Service Name', value: e.serviceName),
              DataGridCell<String>(
                columnName: 'Status',
                value: e.claimStatus,
              ),
              DataGridCell<String>(
                columnName: 'Particulars',
                value: e.particulars,
              ),
            ]))
        .toList();
  }

  List<DataGridRow> _claimData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _claimData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
      return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          cell.value.toString(),
        ),
      );
    }).toList());
  }
}
