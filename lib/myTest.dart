import 'package:flutter/material.dart';



class NameListScreen extends StatefulWidget {
  @override
  _NameListScreenState createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  // Sample data in the list
  List<String> names = [
    "Nahid Hossain",
    "NM Sujon",
    "John Doe",
    "Jane Smith",
  ];

  void _removeName(int index) {
    setState(() {
      names.removeAt(index);  // Remove item from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Name List with Remove Icon")),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              names[index],
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red), // Remove icon
              onPressed: () {
                _removeName(index);  // Call remove function when clicked
              },
            ),
          );
        },
      ),
    );
  }
}

