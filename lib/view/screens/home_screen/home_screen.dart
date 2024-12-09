// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(

        ),
      ),

      bottomNavigationBar: NavBar(
        currentIndex: 0,
      ),
    );
  }

}
