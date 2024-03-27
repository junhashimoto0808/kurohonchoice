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
  final _editingController = TextEditingController();

  List<String> style = List.empty(growable: true);
  List<Image> jazzMen = List.empty(growable: true);

  bool selected = false;

  final _metronomePlugin = Metronome();

  String metronometempo = '0';

  String metronomeIcon = 'images/metronome-left.png';
  String metronomeIconRight = 'images/metronome-right.png';
  String metronomeIconLeft = 'images/metronome-left.png';

  String currentStyle = "We'll choose a style. Right now.";
  Image currentImage = Image.asset('images/s_miles.png');

  int _condNote = 1;

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
  }

  @override
  void initState() {
    super.initState();

    _metronomePlugin.init(
      'lib/assets/audio/metronome-85688.mp3',
      //'lib/assets/audio/hihat44_wav.wav',
      bpm: 120,
      volume: 100,
    );

    _metronomePlugin.onListenTick((_) {
      //print('tick');

      setState(() {
        if (metronomeIcon == metronomeIconRight) {
          metronomeIcon = metronomeIconLeft;
        } else {
          metronomeIcon = metronomeIconRight;
        }
      });
    });
    _editingController.text = metronometempo = "120";
  }

// providerのモデルで定義していたmethodをここかく。
  void _selectStyle() {
    // 変更したらUIも変わる操作をsetStateで包む。
    //(providerのchangeNotifier()みたいな役割)
    setState(() {
      int index = Random().nextInt(styleData.length);
      currentStyle = styleData[index][1];
      currentImage = jazzMen[Random().nextInt(jazzMen.length)];

      _editingController.text = metronometempo =
          randomIntWithRange(styleData[index][2], styleData[index][3]);

      currentStyle = '$currentStyle ($metronometempo)';
    });
  }

  String randomIntWithRange(String min, String max) {
    int minint = int.parse(min);
    int maxint = int.parse(max);
    int v;
    int value = Random().nextInt(maxint - minint);
    v = value + minint;
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 240, 253),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            /*
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(1),
            ),*/
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Column(children: <Widget>[
                              Bubble(
                                margin: const BubbleEdges.only(top: 10),
                                elevation: 5.toDouble(),
                                alignment: Alignment.topRight,
                                nip: BubbleNip.rightTop,
                                //color: const Color.fromARGB(255, 225, 255, 199),
                                child: Text(
                                  currentStyle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 150,
                            width: 10,
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

                      /*
                  const Text(
                    "List of Styles and Tempos",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  */

                      // ignore: prefer_const_literals_to_create_immutables
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity, //横幅いっぱいを意味する
                        // 内側の余白（パディング）
                        padding: const EdgeInsets.all(5),
                        // 外側の余白（マージン）
                        margin: const EdgeInsets.all(0),

                        decoration: BoxDecoration(
                          // 枠線
                          border: Border.all(color: Colors.grey, width: 2),
                          // 角丸
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DataTable(
                            headingRowHeight: 30,
                            headingTextStyle: const TextStyle(
                              fontSize: 13,
                            ),
                            dataRowMinHeight: 25,
                            dataRowMaxHeight: 25,
                            columnSpacing: 15,
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
                                label: Text('(Avg)'),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[0][1])),
                                  DataCell(Text(
                                      '${styleData[0][2]}-${styleData[0][3]}')),
                                  DataCell(Text(styleData[0][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[1][1])),
                                  DataCell(Text(
                                      '${styleData[1][2]}-${styleData[1][3]}')),
                                  DataCell(Text(styleData[1][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[2][1])),
                                  DataCell(Text(
                                      '${styleData[2][2]}-${styleData[2][3]}')),
                                  DataCell(Text(styleData[2][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[3][1])),
                                  DataCell(Text(
                                      '${styleData[3][2]}-${styleData[3][3]}')),
                                  DataCell(Text(styleData[3][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[4][1])),
                                  DataCell(Text(
                                      '${styleData[4][2]}-${styleData[4][3]}')),
                                  DataCell(Text(styleData[4][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[5][1])),
                                  DataCell(Text(
                                      '${styleData[5][2]}-${styleData[5][3]}')),
                                  DataCell(Text(styleData[5][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[6][1])),
                                  DataCell(Text(
                                      '${styleData[6][2]}-${styleData[6][3]}')),
                                  DataCell(Text(styleData[6][4])),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text(styleData[7][1])),
                                  DataCell(Text(
                                      '${styleData[7][2]}-${styleData[7][3]}')),
                                  DataCell(Text(styleData[7][4])),
                                ],
                              ),
                            ]),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity, //横幅いっぱいを意味する
                        // 内側の余白（パディング）
                        padding: const EdgeInsets.all(5),
                        // 外側の余白（マージン）
                        margin: const EdgeInsets.all(0),

                        decoration: BoxDecoration(
                          // 枠線
                          border: Border.all(color: Colors.grey, width: 2),
                          // 角丸
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(children: [
                          Image.asset(
                            metronomeIcon,
                            height: 30,
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              setState(() {
                                playStopMetronome();
                              });
                            },
                            isSelected: selected,
                            selectedIcon: const Icon(Icons.stop),
                          ),
                          SizedBox(
                              height: 25,
                              width: 50,
                              // Expandedを追加してTextFieldに幅の制約を提供する
                              child: TextField(
                                controller: _editingController,
                                enabled: true,
                                // 入力数
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'tempo',
                                  counterText: '', // ここを追加！！
                                ),
                                //maxLengthEnforcement: false,
                                //style: TextStyle(color: Colors.red),
                                obscureText: false,
                                maxLines: 1,
                                //パスワード
                                onChanged: (text) {
                                  setState(() {
                                    metronometempo = text;
                                    if (checkTempo(metronometempo)) {
                                      changeTempo();
                                    }
                                  });
                                },
                              )),
                          Radio(
                              value: 1,
                              groupValue: _condNote,
                              onChanged: (value) {
                                setState(() {
                                  _condNote = value as int;
                                  changeTempo();
                                });
                              }),
                          //const SizedBox(width: 0.0),
                          const Text(
                            'quarter',
                            style: TextStyle(fontSize: 13),
                          ),
                          Radio(
                              value: 2,
                              groupValue: _condNote,
                              onChanged: (value) {
                                setState(() {
                                  _condNote = value as int;
                                  changeTempo();
                                });
                              }),
                          //const SizedBox(width: 0.0),
                          const Text(
                            'half',
                            style: TextStyle(fontSize: 13),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ],
            ),
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
                changeTempo();
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
      ),
    );
  }

  bool checkTempo(String tempo) {
    try {
      int.tryParse(tempo);
    } on FormatException {
      return false;
    }

    if (int.tryParse(tempo) == null ||
        int.parse(tempo) < 30 ||
        400 < int.parse(tempo)) {
      return false;
    }
    return true;
  }

  void changeTempo() {
    double a = int.parse(metronometempo) / _condNote;
    int tempo = a.toInt();
    _metronomePlugin.setBPM(tempo);
  }

  void playStopMetronome() {
    selected = !selected;
    if (selected) {
      if (checkTempo(metronometempo) == false) {
        showDialog<void>(
            context: context,
            builder: (_) {
              return const AlertDialogSample();
            });
        selected = !selected;
        return;
      }
      double a = int.parse(metronometempo) / _condNote;
      int tempo = a.toInt();

      _metronomePlugin.setVolume(100);
      _metronomePlugin.play(tempo);
    } else {
      _metronomePlugin.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (!selected) {
      _metronomePlugin.stop();
    }
    _metronomePlugin.destroy();
  }
}

class AlertDialogSample extends StatelessWidget {
  const AlertDialogSample({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Please set the tempo between 30 and 400.'),
      actions: <Widget>[
        GestureDetector(
          child: const Text('OK'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
