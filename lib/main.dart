import 'package:flutter/material.dart';

import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/categories_page.dart';
import 'pages/categories_meals_page.dart';
import 'utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas a Realizar',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.pink,
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
      routes: {
        AppRoutes.HOME: (ctx) => const CategoriesPage(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => const CategoriesMealsPage(),
      },
    );
  }
}
