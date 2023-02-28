import 'package:employee_app/page/create_update_employee_page.dart';
import 'package:employee_app/page/employee_page.dart';
import 'package:employee_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'constant/route_name.dart';
import 'page/home_page.dart';
import 'page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      initialRoute: RoutesName.LOGIN,
      onGenerateRoute: (settings) {
        RouteGenerator.generateRoute(settings, settings.name);
      },
      routes: {
        RoutesName.HOME_PAGE: (context) => const HomePage(),
        RoutesName.LOGIN: (context) => const LoginPage(),
        RoutesName.EMPLOYEE: (context) => const EmployeePage(),
        RoutesName.EMPLOYEE_CREATE_UPDATE: (context) =>
            CreateUpdateProfilePage(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: const Color(0xffaa2929))),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, String? name) {
    switch (name) {
      case RoutesName.LOGIN:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      case RoutesName.HOME_PAGE:
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      case RoutesName.EMPLOYEE:
        return MaterialPageRoute(
            builder: (context) => const EmployeePage(), settings: settings);
      case RoutesName.EMPLOYEE_CREATE_UPDATE:
        return MaterialPageRoute(
            builder: (context) => const CreateUpdateProfilePage(),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
    }
  }
}
