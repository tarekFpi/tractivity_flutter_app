import 'package:flutter/material.dart';
import 'package:tractivity_app/view/components/nav_bar/nav_bar.dart';
class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}
