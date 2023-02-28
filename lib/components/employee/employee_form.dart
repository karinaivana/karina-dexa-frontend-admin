import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/api_call/employee.dart';
import 'package:employee_app/api_call/role.dart';
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
  RoleApi roleApi = RoleApi();
  bool _showPassword = false;
  List<Role>? roles;
  late String _selectedRole;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  late TextEditingController photoLinkController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    nameController = TextEditingController(text: widget.employee?.name);
    photoLinkController =
        TextEditingController(text: widget.employee?.photoLink);
    phoneNumberController =
        TextEditingController(text: widget.employee?.phoneNumber);
    passwordController = TextEditingController(text: widget.employee?.password);
    emailController = TextEditingController(text: widget.employee?.email);

    await getAllRole();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    photoLinkController.dispose();
    super.dispose();
  }

  Future<void> getAllRole() async {
    try {
      var response = await roleApi.getAllRoleList();

      if (response != null && response.success) {
        setState(() {
          _selectedRole = widget.employee?.role.id ?? response.roleDTOS[0].id;
          roles = response.roleDTOS;
        });
      }
    } catch (e) {
      print("error while get role data" + e.toString());
    }
  }

  Future<void> saveEmployeeData() async {
    CreateOrUpdateEmployeeByAdminRequest request =
        CreateOrUpdateEmployeeByAdminRequest(
            widget.employee?.id,
            nameController.text,
            emailController.text,
            passwordController.text,
            _selectedRole,
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

  Widget roleInputDropdown() {
    return InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.people),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
          hintText: 'Masukkan role karyawan',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      isEmpty: _selectedRole == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRole,
          isDense: true,
          onChanged: (String? value) {
            setState(() {
              _selectedRole = value!;
            });
          },
          items: roles?.map((Role role) {
            return DropdownMenuItem<String>(
              value: role.id,
              child: Text(role.description),
            );
          }).toList(),
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
            if (roles != null) roleInputDropdown(),
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
