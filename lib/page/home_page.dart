import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/components/home_page/table_attendance.dart';
import 'package:employee_app/components/navbar.dart';
import 'package:employee_app/data/admin.dart';
import 'package:flutter/material.dart';

import '../api_call/attendance_list.dart';
import '../data/all_attendance_list.dart';
import '../utils/shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AttendanceApi _attendanceApi = AttendanceApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  bool _isloading = true;
  List<AttendanceList>? _attendanceList;
  Admin? _admin;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await loadData();

    setState(() {
      _isloading = false;
    });
  }

  Future<void> loadData() async {
    var response = await _attendanceApi.getEmployeeAttendanceList();

    if (response != null && response.success) {
      setState(() {
        _attendanceList = response.attendanceListDTOS;
      });
    }
  }

  Widget tableArea() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const AutoSizeText(
              "Daftar Absensi Karyawan:",
              maxLines: 1,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Padding(padding: EdgeInsets.only(bottom: 15)),
            if (_attendanceList != null)
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:
                      TableAttendance(emplooyeeAttandanceList: _attendanceList))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: Text("Aplikasi Monitoring Absensi"),
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
                          "Selamat Datang di Aplikasi Monitoring Karyawan",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        tableArea()
                      ]),
                )),
    );
  }
}
