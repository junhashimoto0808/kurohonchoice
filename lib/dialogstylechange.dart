import 'dart:math';

import 'package:flutter/material.dart';

class DialogStyleChange extends StatefulWidget {
  const DialogStyleChange({super.key});

  @override
  State<DialogStyleChange> createState() => _HomePageState2();
}

class _HomePageState2 extends State<DialogStyleChange>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  List<String> style = List.empty(growable: true);

  @override
  _HomePageState2() {
    style.add("Ballad");
    style.add("Bossa Nova");
    style.add("Latin");
    style.add("Up Tempo Swing");
    style.add("Medium Up Swing");
    style.add("Medium Swing");
    style.add("Slow Swing");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    style[0],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[1],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[2],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[3],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[4],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[5],
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    style[6],
                    style: TextStyle(fontSize: 20),
                  ),
                  Center(
                    // ここを追加
                    child: Image.asset('images/miles-davis-logo.png'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            // Use the controller to run the animation with rollTo method
            onPressed: () {},
            child: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(
            height: 16 /*間隔*/,
          ),
          FloatingActionButton(
            child: const Icon(
              Icons.chevron_left,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
