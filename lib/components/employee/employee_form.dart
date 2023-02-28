import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/api_call/employee.dart';
import 'package:flutter/material.dart';

import '../../constant/route_name.dart';
import '../../data/crud_employee.dart';
import '../../utils/shared_pref.dart';

class EmployeeForm extends StatefulWidget {
  final Employee? employee;

  const EmployeeForm({super.key, this.employee});

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final SharedPrefForObject sharedPref = SharedPrefForObject();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmployeeApi employeeApi = EmployeeApi();

  bool _showPassword = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController roleController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController photoLinkController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    photoLinkController =
        TextEditingController(text: widget.employee?.photoLink);
    phoneNumberController =
        TextEditingController(text: widget.employee?.phoneNumber);
    passwordController = TextEditingController(text: widget.employee?.password);
    nameController = TextEditingController(text: widget.employee?.name);
    emailController = TextEditingController(text: widget.employee?.email);
    roleController = TextEditingController(text: widget.employee?.role);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    roleController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    photoLinkController.dispose();
    super.dispose();
  }

  Future<void> saveEmployeeData() async {
    CreateOrUpdateEmployeeByAdminRequest request =
        CreateOrUpdateEmployeeByAdminRequest(
            widget.employee?.id,
            nameController.text,
            emailController.text,
            passwordController.text,
            roleController.text,
            phoneNumberController.text,
            photoLinkController.text);

    var response = await employeeApi.createOrUpdateEmployee(
        createOrUpdateEmployeeByAdminRequest: request);

    if (response != null && response.employee != null) {
      sharedPref.remove("employee_data");

      Navigator.of(context).pushNamed(RoutesName.EMPLOYEE);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => saveDataFailedDialog(),
      );
    }
  }

  Widget saveDataFailedDialog() {
    return AlertDialog(
      title: const Text('Buat/Edit Akun Gagal'),
      content: const Text('Mohon periksa kembali input yang dimasukkan'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff9f2a28)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveEmployeeData();
          }
        },
        child: AutoSizeText(
          widget.employee == null ? 'BUAT AKUN' : 'EDIT AKUN',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama karyawam';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email Perusahaan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan email perusahaan karyawaan';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.people),
                  hintText: 'Role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: roleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan role karyawan';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Nomor Handphone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nomor handphone anda';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              child: TextFormField(
                obscureText: !_showPassword,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    hintText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    )),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kata sandi anda';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(children: [
                Checkbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
                AutoSizeText("Lihat Kata Sandi", maxLines: 1)
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.photo),
                  hintText: 'Link Photo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: photoLinkController,
              ),
            ),
            saveButton()
          ],
        ));
  }
}
