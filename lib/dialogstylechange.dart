import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kurohonchoice/bubble/bubble.dart';
import 'package:kurohonchoice/styledata.dart';
import 'package:metronome/metronome.dart';

class DialogStyleChange extends StatefulWidget {
  const DialogStyleChange({super.key});

  @override
  State<DialogStyleChange> createState() => _HomePageState2();
}

class _HomePageState2 extends State<DialogStyleChange>
    with SingleTickerProviderStateMixin {
  List<String> style = List.empty(growable: true);
  List<Image> jazzMen = List.empty(growable: true);

  String currentStyle = "";
  Image currentImage = Image.asset('images/s_miles.png');

  bool selected = false;

  final _metronomePlugin = Metronome();

  @override
  _HomePageState2() {
    style.add("");
    style.add("Ballad");
    style.add("Bossa Nova");
    style.add("Latin");
    style.add("Up Tempo Swing");
    style.add("Medium Up Swing");
    style.add("Medium Swing");
    style.add("Slow Swing");

    jazzMen.add(Image.asset('images/s_bud.png'));
    jazzMen.add(Image.asset('images/s_canonball.png'));
    jazzMen.add(Image.asset('images/s_chick.png'));
    jazzMen.add(Image.asset('images/s_coltrane.png'));
    jazzMen.add(Image.asset('images/s_evans.png'));
    jazzMen.add(Image.asset('images/s_jaco.png'));
    jazzMen.add(Image.asset('images/s_joepass.png'));
    jazzMen.add(Image.asset('images/s_miles.png'));
    jazzMen.add(Image.asset('images/s_monk.png'));
    jazzMen.add(Image.asset('images/s_oscar.png'));
    jazzMen.add(Image.asset('images/s_paker.png'));
    jazzMen.add(Image.asset('images/s_rollins.png'));
    jazzMen.add(Image.asset('images/s_stan.png'));
    jazzMen.add(Image.asset('images/s_wynton.png'));

    currentStyle = style[0];
    currentImage = Image.asset('images/s_miles.png');
  }

  @override
  void initState() {
    super.initState();

    _metronomePlugin.init(
      //'lib/assets/audio/metronome-85688.mp3',
      'lib/assets/audio/hihat44_wav.wav',
      bpm: 120,
      volume: 100,
    );

    _metronomePlugin.onListenTick((_) {
      print('tick');
      setState(() {
        /*
        if (metronomeIcon == metronomeIconRight) {
          metronomeIcon = metronomeIconLeft;
        } else {
          metronomeIcon = metronomeIconRight;
        }
        */
      });
    });
  }

// providerのモデルで定義していたmethodをここかく。
  void _selectStyle() {
    // 変更したらUIも変わる操作をsetStateで包む。
    //(providerのchangeNotifier()みたいな役割)
    setState(() {
      currentStyle = styleData[Random().nextInt(styleData.length)][1];
      currentImage = jazzMen[Random().nextInt(jazzMen.length)];
    });
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
                  const Text(
                    "List of Styles and Tempos",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  const SizedBox(height: 10),
                  DataTable(
                      headingRowHeight: 50,
                      dataRowMinHeight: 25,
                      dataRowMaxHeight: 25,
                      columnSpacing: 30,
                      dataTextStyle: const TextStyle(
                        fontSize: 13 /*テキストのサイズ*/,
                        color: Colors.black,
                      ),
                      columns: const [
                        DataColumn(
                          label: Text('Style'),
                        ),
                        DataColumn(
                          label: Text('Tempo'),
                        ),
                        DataColumn(
                          label: Text('Tempo\nAvg'),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[0][1])),
                            DataCell(
                                Text('${styleData[0][2]}-${styleData[0][3]}')),
                            DataCell(Text(styleData[0][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[1][1])),
                            DataCell(
                                Text('${styleData[1][2]}-${styleData[1][3]}')),
                            DataCell(Text(styleData[1][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[2][1])),
                            DataCell(
                                Text('${styleData[2][2]}-${styleData[2][3]}')),
                            DataCell(Text(styleData[2][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[3][1])),
                            DataCell(
                                Text('${styleData[3][2]}-${styleData[3][3]}')),
                            DataCell(Text(styleData[3][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[4][1])),
                            DataCell(
                                Text('${styleData[4][2]}-${styleData[4][3]}')),
                            DataCell(Text(styleData[4][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[5][1])),
                            DataCell(
                                Text('${styleData[5][2]}-${styleData[5][3]}')),
                            DataCell(Text(styleData[5][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[6][1])),
                            DataCell(
                                Text('${styleData[6][2]}-${styleData[6][3]}')),
                            DataCell(Text(styleData[6][4])),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(styleData[7][1])),
                            DataCell(
                                Text('${styleData[7][2]}-${styleData[7][3]}')),
                            DataCell(Text(styleData[7][4])),
                          ],
                        ),
                      ]),
                  const SizedBox(height: 60),
                  const Text(
                    "Select Result",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  /*
                  Text(
                    "  ${style[0]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[1]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[2]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[3]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[4]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[5]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[6]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "  ${style[7]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  */
                  //const SizedBox(height: 30),
                  /*
                        child: Container(
                            height: 150,
                            alignment: Alignment.centerRight,
                            child: SpeechBalloon(
                              nipLocation: NipLocation.right,
                              borderColor: Colors.green,
                              height: 40, // マルなので同じheightとwidth
                              width: 300,
                              borderRadius: 40,
                              offset: const Offset(
                                  0, -1), // 棘の位置がずれてしまったのでoffsetで位置を修正してあげる
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*
                                  const Icon(
                                    Icons.music_note,
                                    color: Colors.green,
                                  ),
                                  */
                                  Text(
                                    currentStyle,
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            )),
                      */
                  /*
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: BubbleBorder(
                              width: 1,
                              radius: 6,
                            ),
                          ),
                          child: Text(currentStyle),
                        ),
                      */
                  Row(
                    children: [
                      Expanded(
                        child: Column(children: <Widget>[
                          Bubble(
                            margin: const BubbleEdges.only(top: 10),
                            elevation: 5.toDouble(),
                            alignment: Alignment.topRight,
                            nip: BubbleNip.rightTop,
                            color: const Color.fromARGB(255, 225, 255, 199),
                            child: Text(
                              currentStyle,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 150,
                        width: 130,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: currentImage),
                      )
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {
                      setState(() {
                        selected = !selected;
                        if (selected) {
                          _metronomePlugin.setVolume(100);
                          _metronomePlugin.play(120);
                        } else {
                          _metronomePlugin.pause();
                        }
                      });
                    },
                    isSelected: selected,
                    selectedIcon: const Icon(Icons.settings),
                  ),
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
            onPressed: () {
              _selectStyle();
            },
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
