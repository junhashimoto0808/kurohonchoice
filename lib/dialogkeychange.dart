// ignore: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kurohonchoice/arrow.dart';
import 'package:roulette/roulette.dart';

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    super.key,
    required this.controller,
  });

  final RouletteController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Roulette(
              // Provide controller to update its state
              controller: controller,
              // Configure roulette's appearance
              style: const RouletteStyle(
                dividerThickness: 0.0,
                dividerColor: Colors.black,
                centerStickSizePercent: 0.05,
                centerStickerColor: Colors.black,
              ),
            ),
          ),
        ),
        const Arrow(),
      ],
    );
  }
}

class DialogKeyChange extends StatefulWidget {
  const DialogKeyChange({super.key});

  @override
  State<DialogKeyChange> createState() => _HomePageState();
}

class _HomePageState extends State<DialogKeyChange>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  late RouletteController _controller;
  //bool _clockwise = true;

/*
  final colors = <Color>[
    Colors.red.withAlpha(50),
    Colors.green.withAlpha(30),
    Colors.blue.withAlpha(70),
    Colors.yellow.withAlpha(90),
    Colors.amber.withAlpha(50),
    Colors.indigo.withAlpha(70),
  ];
*/
  final colors = <Color>[
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
    Colors.blue.withAlpha(70),
    Colors.indigo.withAlpha(70),
  ];

  final texts = [
    'C',
    'Db',
    'D',
    'Eb',
    'E',
    'F',
    'Gb',
    'G',
    'Ab',
    'A',
    'Bb',
    'B',
  ];

  @override
  void initState() {
    super.initState();

    final group = RouletteGroup.uniform(
      12,
      colorBuilder: (index) {
        return colors[index];
      },
      textBuilder: (index) {
        return texts[index];
      },
    );
    _controller = RouletteController(vsync: this, group: group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
          //title: const Text('Roulette'),
          ),
          */
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyRoulette(controller: _controller),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /*
      floatingActionButton: FloatingActionButton(
        // Use the controller to run the animation with rollTo method
        onPressed: () => _controller.rollTo(
          3,
          //clockwise: _clockwise,
          //minRotateCircles : Rotate
          //duration: Durations.extralong1,
          //curve: Curves.ease,
          offset: _random.nextDouble() * 12,
        ),
        child: const Icon(Icons.refresh_rounded),
      ),
      */
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            // Use the controller to run the animation with rollTo method
            onPressed: () => _controller.rollTo(
              3,
              //clockwise: _clockwise,
              //minRotateCircles : Rotate
              duration: Durations.extralong4,
              curve: Curves.fastLinearToSlowEaseIn,
              offset: _random.nextDouble() * 12,
            ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
