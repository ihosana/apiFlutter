import 'package:flutter/material.dart';
import 'package:terceira_prova_pok/widget/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => TelaHome();
}