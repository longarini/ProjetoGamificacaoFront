import 'package:flutter/material.dart';
import 'package:front_gamific/pages/auth/auth_app_page.dart';
import 'package:front_gamific/pages/auth/auth_page.dart';
import 'package:front_gamific/pages/groups/add_group_page.dart';
import 'package:front_gamific/pages/groups/admin_groups_page.dart';
import 'package:front_gamific/pages/groups/user_group_page.dart';
import 'package:front_gamific/pages/tasks/task_page.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.blue,
              secondary: Colors.amber,
            ),
            canvasColor: const Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                  ),
                )),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (ctx) => const AuthAppPage(),
          AppRoutes.AUTH: (ctx) => const AuthPage(),
          AppRoutes.TASKS: (ctx) => const TaskPage(),
          AppRoutes.ADD_GROUP: (ctx) => const AddGroupPage(),
          AppRoutes.ADMINGROUP: (ctx) => const AdminGroupsPage(),
          AppRoutes.USERGROUP: (ctx) => const UserGroupsPage(),
        });
  }
}
