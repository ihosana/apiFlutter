import 'package:flutter/material.dart';
import 'package:terceira_prova_pok/widget/home.dart';
import 'package:terceira_prova_pok/widget/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => TelaHome();
}