
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee_app/api_call/admin.dart';
import 'package:employee_app/data/admin.dart';
import 'package:flutter/material.dart';

import '../utils/shared_pref.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Aplikasi Monitoring Absensi"),
        ),
        backgroundColor: Colors.white,
        body: LoginPageBody());
  }
}

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            "Masuk",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
        const LoginForm()
      ]),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AdminApi adminApi = AdminApi();
  final SharedPrefForObject sharedPref = SharedPrefForObject();

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeShowPasswordValue() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<void> loginToServer() async {
    LoginAdminRequest request =
        LoginAdminRequest(usernameController.text, passwordController.text);

    var response = await adminApi.login(loginRequest: request);

    if (response != null && response.admin != null) {
      sharedPref.save('admin_data', jsonEncode(response.admin));

      Navigator.of(context).pushNamed('/homepage');
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => loginFailedDialog(),
      );
    }
  }

  Widget loginFailedDialog() {
    return AlertDialog(
      title: const Text('Login Gagal'),
      content: const Text('Mohon periksa kembali email atau password anda'),
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

  Widget loginButton() {
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
            loginToServer();
          }
        },
        child: const Text(
          'MASUK',
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
                  prefixIcon: Icon(Icons.people),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan username anda';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextFormField(
                obscureText: !_showPassword,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  hintText: 'Kata Sandi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
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
              margin: EdgeInsets.only(bottom: 15),
              child: Row(children: [
                Checkbox(
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
                const AutoSizeText("Lihat Kata Sandi", maxLines: 1)
              ]),
            ),
            loginButton()
          ],
        ));
  }
}
