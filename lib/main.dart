import 'package:comprar_oque/screens/home.dart';
import 'package:comprar_oque/screens/ItemsList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const HomeBuyListWidget(),
        "/list": (context) => const ItemListWidget(),
      },
      initialRoute: "/",
    );
  }
}
