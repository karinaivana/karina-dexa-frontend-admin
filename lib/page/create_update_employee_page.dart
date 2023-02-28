import 'dart:convert';

import 'package:employee_app/components/employee/employee_form.dart';
import 'package:flutter/material.dart';

import '../constant/route_name.dart';
import '../data/crud_employee.dart';
import '../utils/shared_pref.dart';

class CreateUpdateProfilePage extends StatefulWidget {
  const CreateUpdateProfilePage({super.key});

  @override
  State<CreateUpdateProfilePage> createState() =>
      _CreateUpdateProfilePageState();
}

class _CreateUpdateProfilePageState extends State<CreateUpdateProfilePage> {
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  bool _isloading = true;
  Employee? _employee;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await getEmployeeData();
    setState(() {
      _isloading = false;
    });
  }

  Future<void> getEmployeeData() async {
    var data = await sharedPref.read("employee_data");

    if (data != null) {
      Employee currentEmployee = Employee.fromJson(jsonDecode(data));

      if (currentEmployee != null) {
        setState(() {
          _employee = currentEmployee;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () async {
                await sharedPref.remove("employee_data");
                ;
                Navigator.pop(context);
              }),
          title: const Text("Aplikasi Absensi Karyawan"),
        ),
        backgroundColor: Colors.white,
        body: _isloading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      _employee == null ? "Buat Akun" : "Edit Akun",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                  ),
                  EmployeeForm(employee: _employee)
                ]),
              ));
  }
}
