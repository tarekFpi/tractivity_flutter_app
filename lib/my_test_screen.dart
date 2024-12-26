import 'package:flutter/material.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // REPLACED: RaisedButton class with Elevated button class.
      // Raisedbutton is deprecatred and shouldn't be used.

      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          // adding some properties
          showModalBottomSheet(
            context: context,
            // color is applied to main screen when modal bottom screen is displayed
            barrierColor: Colors.greenAccent,
            //background color for modal bottom screen
            backgroundColor: Colors.yellow,
            //elevates modal bottom screen
            elevation: 10,
            // gives rounded corner to modal bottom screen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            builder: (BuildContext context) {
              // UDE : SizedBox instead of Container for whitespaces
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('GeeksforGeeks'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
