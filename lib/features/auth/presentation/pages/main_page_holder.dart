// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MainPageHolder extends StatefulWidget {
  const MainPageHolder({super.key});

  @override
  State<MainPageHolder> createState() => _MainPageHolderState();
}

class _MainPageHolderState extends State<MainPageHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [Text('Home Page')],
        ),
      ),
    );
  }
}
