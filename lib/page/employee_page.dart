import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/data/crud_employee.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../api_call/employee.dart';
import '../components/navbar.dart';
import '../constant/route_name.dart';
import '../utils/shared_pref.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeApi _employeeApi = EmployeeApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  bool _isloading = true;
  List<Employee>? _employeeList;
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await loadData();

    _employeeDataSource = EmployeeDataSource(_employeeList!);

    setState(() {
      _isloading = false;
    });
  }

  Future<void> loadData() async {
    var response = await _employeeApi.getAllEmployeeData();

    if (response != null && response.success) {
      setState(() {
        _employeeList = response.employeeList;
      });
    }
  }

  Widget loadEmployeeTable() {
    return SfDataGrid(
        source: _employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: [
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const AutoSizeText('ID'),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const AutoSizeText('Nama'),
            ),
          ),
          GridColumn(
            columnName: 'email',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const AutoSizeText('Email'),
            ),
          ),
          GridColumn(
            columnName: 'role',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const AutoSizeText('Role'),
            ),
          ),
          GridColumn(
            columnName: 'edit',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const AutoSizeText('Ubah Data',
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Navbar(),
        appBar: AppBar(
          title: const AutoSizeText("Aplikasi Absensi Karyawan"),
        ),
        body: SingleChildScrollView(
            child: _isloading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(
                        top: 30, right: 20, left: 20, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Daftar Absensi Karyawan:",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 15)),
                          loadEmployeeTable()
                        ]),
                  )));
  }
}

class EmployeeDataSource extends DataGridSource {
  var employeeMap = {};

  EmployeeDataSource(List<Employee> employees) {
    employees
        .forEach((employeeData) => employeeMap[employeeData.id] = employeeData);

    buildDataGridRow(employees);
  }

  Future<void> clickEditButton(
      int employeeIdSelected, BuildContext context) async {
    final SharedPrefForObject sharedPref = SharedPrefForObject();

    Employee data = employeeMap[employeeIdSelected];

    if (data != null) {
      sharedPref.save('employee_data', jsonEncode(data));
    }

    Navigator.of(context).pushNamed(RoutesName.EMPLOYEE_CREATE_UPDATE);
  }

  void buildDataGridRow(List<Employee> employeeData) {
    dataGridRow = employeeData.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(columnName: 'email', value: employee.email),
        DataGridCell<String>(
            columnName: 'role', value: employee.role.description),
        const DataGridCell<Widget>(columnName: 'edit', value: null),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRow = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRow.isEmpty ? [] : dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          child: dataGridCell.columnName == 'edit'
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return ElevatedButton(
                      onPressed: () {
                        clickEditButton(row.getCells()[0].value, context);
                      },
                      child: const AutoSizeText(
                        'Ubah Data',
                        maxLines: 2,
                      ));
                })
              : Text(dataGridCell.value.toString()));
    }).toList());
  }
}
