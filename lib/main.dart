import 'package:flutter/material.dart';
import 'songdata.dart';
import 'dart:math' as math;
import 'package:url_launcher/link.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ランダム黒本くん',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ランダム黒本くん'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  //final double _fontSize = 15;

  String _songName = '',
      _songVol = '',
      _songCreater = '',
      _songKey = '',
      _songBeat = '',
      _songIsBluesRhythmChange = '',
      _songStyle = '';

  int _condVol = 0;
  String _condStyle = '';
  String _condSongName = '';
  String _condCreaterName = '';

  List<String> choiceStyle = List.empty(growable: true);

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  _MyHomePageState() {
    choiceStyle.add('');
    for (var i = 0; i < songData.length; i++) {
      choiceStyle.add(songData[i][7]);
    }
    choiceStyle = choiceStyle.toSet().toList();
    choiceStyle.sort(((a, b) => a.compareTo(b)));
    return;
  }

  void _choiceSong() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      //_counter++;

      List<int> randomIntArray = <int>[];
      var randomSeed = math.Random();
      int random = 0;

      while (randomIntArray.length < songData.length) {
        random = randomSeed.nextInt(songData.length);
        if (!randomIntArray.contains(random)) {
          randomIntArray.add(random);
        }
      }

      var i = 0;
      int a = 0;
      for (i = 0; i < randomIntArray.length; i++) {
        a = randomIntArray[i];
        if (_condVol != 0) {
          if (int.parse(songData[a][0]) != _condVol) {
            continue;
          }
        }

        if (_condStyle != '') {
          if (songData[a][7] != _condStyle) {
            continue;
          }
        }

        if (_condSongName != '') {
          if (!songData[a][1]
              .toUpperCase()
              .contains(_condSongName.toUpperCase())) {
            continue;
          }
        }

        if (_condCreaterName != '') {
          if (!songData[a][2]
              .toUpperCase()
              .contains(_condCreaterName.toUpperCase())) {
            continue;
          }
        }
        break;
      }

      if (i == randomIntArray.length) {
        // not found
        _songName = '';
        _songVol = '';
        _songCreater = '';
        _songKey = '';
        _songBeat = '';
        _songIsBluesRhythmChange = '';
        _songStyle = '';
      } else {
        // found
        _songName = songData[a][1];
        _songVol = songData[a][0];
        _songCreater = songData[a][2];
        _songKey = songData[a][4];
        _songBeat = songData[a][5];
        _songIsBluesRhythmChange = songData[a][6];
        _songStyle = songData[a][7];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text(widget.title),
      ),

      body: Builder(
          builder: ((context) => SingleChildScrollView(
              child: SelectionArea(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          (Scaffold.of(context).appBarMaxHeight ?? 0),
                      // ignore: sort_child_properties_last
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity, //横幅いっぱいを意味する
                            // 内側の余白（パディング）
                            padding: const EdgeInsets.all(10),
                            // 外側の余白（マージン）
                            margin: const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              // 枠線
                              border: Border.all(color: Colors.grey, width: 2),
                              // 角丸
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              // Column is also a layout widget. It takes a list of children and
                              // arranges them vertically. By default, it sizes itself to fit its
                              // children horizontally, and tries to be as tall as its parent.
                              //
                              // Column has various properties to control how it sizes itself and
                              // how it positions its children. Here we use mainAxisAlignment to
                              // center the children vertically; the main axis here is the vertical
                              // axis because Columns are vertical (the cross axis would be
                              // horizontal).
                              //
                              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                              // action in the IDE, or press "p" in the console), to see the
                              // wireframe for each widget.

                              //hashi mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Text(
                                  //'曲名：'
                                  _songName,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Text(
                                  '',
                                  style: TextStyle(fontSize: 15),
                                ),
                                DataTable(
                                  /*
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(3),
                  },
                  */
                                  headingRowHeight: 0,
                                  dataRowMinHeight: 25,
                                  dataRowMaxHeight: 25,
                                  dataTextStyle: const TextStyle(
                                    fontSize: 13 /*テキストのサイズ*/,
                                    color: Colors.black,
                                  ),
                                  columns: const [
                                    DataColumn(
                                      //label: SizedBox(width: 5, child: Text('aaa')),
                                      label: Text(''),
                                    ),
                                    DataColumn(
                                      //label: SizedBox(width: 5, child: Text('bbb')),
                                      label: Text(''),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('巻')),
                                        DataCell(Text(_songVol)),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('作曲者')),
                                        DataCell(Text(_songCreater)),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('キー')),
                                        DataCell(Text(_songKey)),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('拍子')),
                                        DataCell(Text(_songBeat)),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('Blues/循環')),
                                        DataCell(
                                            Text(_songIsBluesRhythmChange)),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(Text('スタイル')),
                                        DataCell(Text(_songStyle)),
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  '',
                                  style: TextStyle(fontSize: 5),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      '検索：',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Link(
                                      // 開きたいWebページのURLを指定
                                      //String uriText = 'https://www.youtube.com/' + 'Jazz' + _songName;
                                      uri: Uri.parse(
                                          'https://www.youtube.com/results?search_query=Jazz $_songName'),
                                      // targetについては後述
                                      target: LinkTarget.blank,
                                      builder: (BuildContext ctx,
                                          FollowLink? openLink) {
                                        return TextButton(
                                          onPressed: openLink,
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                            // minimumSize:
                                            //     MaterialStateProperty.all(Size.zero),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text(
                                            'Youtube',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        );
                                      },
                                    ),
                                    const Text(
                                      '',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Link(
                                      // 開きたいWebページのURLを指定
                                      //String uriText = 'https://www.youtube.com/' + 'Jazz' + _songName;
                                      uri: Uri.parse(
                                          'https://www.google.com/search?q=Jazz $_songName'),
                                      // targetについては後述
                                      target: LinkTarget.blank,
                                      builder: (BuildContext ctx,
                                          FollowLink? openLink) {
                                        return TextButton(
                                          onPressed: openLink,
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                            // minimumSize:
                                            //     MaterialStateProperty.all(Size.zero),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text(
                                            'Google',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  const Text(
                                    'クリップボードにコピー：',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      // minimumSize:
                                      //     MaterialStateProperty.all(Size.zero),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () async {
                                      // ボタンが押されたときに発動される処理
                                      final data =
                                          ClipboardData(text: _songName);
                                      await Clipboard.setData(data);
                                    },
                                    child: const Text(
                                      '曲名',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  const Text(
                                    '',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      // minimumSize:
                                      //     MaterialStateProperty.all(Size.zero),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () async {
                                      // ボタンが押されたときに発動される処理
                                      final data =
                                          ClipboardData(text: _songCreater);
                                      await Clipboard.setData(data);
                                    },
                                    child: const Text(
                                      '作曲者',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity, //横幅いっぱいを意味する
                            // 内側の余白（パディング）
                            padding: const EdgeInsets.all(10),
                            // 外側の余白（マージン）
                            margin: const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              // 枠線
                              border: Border.all(color: Colors.grey, width: 2),
                              // 角丸
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  '検索条件',
                                  style: TextStyle(fontSize: 13),
                                ),
                                const Text(
                                  '',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Row(children: [
                                  const Text(
                                    '巻：',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Radio(
                                      value: 0,
                                      groupValue: _condVol,
                                      onChanged: (value) {
                                        setState(() {
                                          _condVol = value as int;
                                        });
                                      }),
                                  //const SizedBox(width: 0.0),
                                  const Text(
                                    '全部',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Radio(
                                      value: 1,
                                      groupValue: _condVol,
                                      onChanged: (value) {
                                        setState(() {
                                          _condVol = value as int;
                                        });
                                      }),
                                  //const SizedBox(width: 0.0),
                                  const Text(
                                    '１巻から',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Radio(
                                      value: 2,
                                      groupValue: _condVol,
                                      onChanged: (value) {
                                        setState(() {
                                          _condVol = value as int;
                                        });
                                      }),
                                  //const SizedBox(width: 0.0),
                                  const Text(
                                    '２巻から',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ]),
                                Row(children: [
                                  const Text(
                                    'スタイル：',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 35.0,
                                    child: DropdownButton<String>(
                                        elevation: 16,
                                        value: _condStyle,
                                        items: choiceStyle
                                            .map((String list) =>
                                                DropdownMenuItem(
                                                    value: list,
                                                    child: Text(list)))
                                            .toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            _condStyle = value!;
                                          });
                                        }),
                                  ),
                                ]),
                                Row(children: [
                                  const Text(
                                    '曲名：',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Flexible(
                                    // ←追加SizedBox(
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 13 /*テキストのサイズ*/,
                                      ),
                                      controller: _controller,

                                      //maxLength: 20,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.android),
                                        hintText: "(部分一致)",
                                        //labelText: "tweet",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _controller.clear();
                                            _condSongName = '';
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                      onChanged: (String txt) {
                                        _condSongName = txt;
                                      },
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  const Text(
                                    '作曲者名：',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Flexible(
                                    // ←追加SizedBox(
                                    child: TextField(
                                      style: const TextStyle(
                                        fontSize: 13 /*テキストのサイズ*/,
                                      ),
                                      controller: _controller2,

                                      //maxLength: 20,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.android),
                                        hintText: "(部分一致)",
                                        //labelText: "tweet",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _controller2.clear();
                                            _condCreaterName = '';
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                      onChanged: (String txt) {
                                        _condCreaterName = txt;
                                      },
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      )))))),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _choiceSong,
        tooltip: 'Choice',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
