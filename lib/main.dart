import 'dart:math';

import 'package:flutter/material.dart';
import 'songdata.dart';
import 'dart:math' as math;
import 'package:url_launcher/link.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
//import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:roulette/roulette.dart';
import 'arrow.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      _songStyle = '',
      _songForVocal = '',
      _songChanges = '';

  int _condVol = 0;
  String _condStyle = '';
  String _condSongName = '';
  String _condCreaterName = '';
  String _condForVocal = '';
  String _condKey = '';

  List<String> choiceStyle = List.empty(growable: true);
  List<String> choiceForVocal = List.empty(growable: true);
  List<String> choiceKey = List.empty(growable: true);

  //String _city = '';

  // バージョン
  String version = '';
  // ビルド番号
  String buildNumber = '';
  // アプリの名前
  String appName = '';
  // パッケージ名
  String packageName = '';

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();

  _MyHomePageState() {
    //スタイルの検索条件を作成
    choiceStyle.add('');
    for (var i = 0; i < songData.length; i++) {
      choiceStyle.add(songData[i][7]);
    }
    choiceStyle = choiceStyle.toSet().toList();
    choiceStyle.sort(((a, b) => a.compareTo(b)));

    // ForVocalの検索条件の作成
    choiceForVocal.add('');
    choiceForVocal.add('あり');

    // Keyの検索条件の作成
    choiceKey.add('');
    choiceKey.add('C');
    choiceKey.add('D♭');
    choiceKey.add('D');
    choiceKey.add('E♭');
    choiceKey.add('E');
    choiceKey.add('F');
    choiceKey.add('G♭');
    choiceKey.add('G');
    choiceKey.add('A♭');
    choiceKey.add('A');
    choiceKey.add('B♭');
    choiceKey.add('B');

    choiceKey.add('Cm');
    choiceKey.add('D♭m');
    choiceKey.add('Dm');
    choiceKey.add('E♭m');
    choiceKey.add('Em');
    choiceKey.add('Fm');
    choiceKey.add('G♭m');
    choiceKey.add('Gm');
    choiceKey.add('A♭m');
    choiceKey.add('Am');
    choiceKey.add('B♭m');
    choiceKey.add('Bm');

    // バージョン情報の取得
    getParam();

    return;
  }

  void getParam() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
    } catch (e) {
      version = e.toString();
    }
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

        if (_condForVocal != '') {
          if (songData[a][8] != _condForVocal) {
            continue;
          }
        }

        if (_condKey != '') {
          if (songData[a][4] != _condKey) {
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
        _songForVocal = '';
        _songChanges = '';
      } else {
        // found
        _songName = songData[a][1];
        _songVol = songData[a][0];
        _songCreater = songData[a][2];
        _songKey = songData[a][4];
        _songBeat = songData[a][5];
        _songIsBluesRhythmChange = songData[a][6];
        _songStyle = songData[a][7];
        _songForVocal = songData[a][8];
        _songChanges = songData[a][9];
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          centerTitle: true,
          title: Text(widget.title),

          /*
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              ;
            },
          )
        ],
        */
        ),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                  height: 75 /*高さ*/,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )),
              ListTile(
                title: const Text('キーランダム選択ツール'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                      //barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        const vd = DialogKeyChange();
                        return vd;
                      });
                },
              ),
              ListTile(
                title: const Text('Help'),
                onTap: () {
                  Navigator.pop(context);
                  launchUrl(Uri.parse(
                      'https://k4134568.github.io/main/randomKurohonHelp.html'));
                },
              ),
              ListTile(
                title: const Text('Version'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog<void>(
                      context: context,
                      builder: (_) {
                        final vd = VersionDialog(version, buildNumber);
                        return vd;
                      });
                },
              ),
            ],
          ),
        ),

        body: Builder(
            builder: ((context) => SingleChildScrollView(
                //child: SelectionArea(
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
                              CopyableText(
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
                                      DataCell(CopyableText(_songCreater)),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('キー')),
                                      DataCell(CopyableText(_songKey)),
                                    ],
                                  ),
                                  /*
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('キー')),
                                      DataCell(GestureDetector(
                                        onTap: () async {
                                          //タップ処理
                                          final String? selectedText =
                                              await showDialog<String>(
                                                  context: context,
                                                  builder: (_) {
                                                    return WillPopScope(
                                                      child:
                                                          const KeyChoiceDialogSample(),
                                                      onWillPop: () async =>
                                                          false,
                                                    );
                                                  });
                                        },
                                        child: Text(
                                          _songKey,
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  */
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('拍子')),
                                      DataCell(Text(_songBeat)),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('Blues/循環')),
                                      DataCell(Text(_songIsBluesRhythmChange)),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('スタイル')),
                                      DataCell(CopyableText(_songStyle)),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('For Vocal')),
                                      DataCell(CopyableText(_songForVocal)),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      const DataCell(Text('改訂版の影響')),
                                      DataCell(CopyableText(_songChanges)),
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
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
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
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Google',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      );
                                    },
                                  ),
                                  Link(
                                    // 開きたいWebページのURLを指定
                                    //String uriText = 'https://www.youtube.com/' + 'Jazz' + _songName;
                                    uri:
                                        Uri.parse('irealb://search?$_songName'),
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
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'iRealPro',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
                                  'For Vocal：',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 35.0,
                                  child: DropdownButton<String>(
                                      elevation: 16,
                                      value: _condForVocal,
                                      items: choiceForVocal
                                          .map((String list) =>
                                              DropdownMenuItem(
                                                  value: list,
                                                  child: Text(list)))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _condForVocal = value!;
                                        });
                                      }),
                                ),
                              ]),
                              Row(children: [
                                const Text(
                                  'キー：',
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 35.0,
                                  child: DropdownButton<String>(
                                      elevation: 16,
                                      value: _condKey,
                                      items: choiceKey
                                          .map((String list) =>
                                              DropdownMenuItem(
                                                  value: list,
                                                  child: Text(list)))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _condKey = value!;
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
                    ))))),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: _choiceSong,
          tooltip: 'Choice',
          child: const Icon(Icons.search),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class CopyableText extends Text {
  const CopyableText(
    String data, {
    Key? key,
    TextStyle? style,
  }) : super(data, key: key, style: style);
  @override
  Widget build(BuildContext context) {
    return InkWell(
//      onLongPress: () =>
//          Clipboard.setData(ClipboardData(text: data.toString())),
      onLongPress: () {
        showDialog<void>(
            context: context,
            builder: (_) {
              final ad = AlertDialogSample();
              ad.copyText = data.toString();
              return ad;
            });
      },
      child: super.build(context),
    );
  }
}

// ignore: must_be_immutable
class AlertDialogSample extends StatelessWidget {
  AlertDialogSample({Key? key}) : super(key: key);
  String copyText = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '文字列をクリップボードにコピーします。よろしいですか？',
        style: TextStyle(fontSize: 13),
      ),
      /*
      content: const Text(
        '',
        style: TextStyle(fontSize: 13),
      ),
      */
      actions: <Widget>[
        GestureDetector(
          child: const Text(
            'いいえ',
            style: TextStyle(fontSize: 13),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: const Text(
            'はい',
            style: TextStyle(fontSize: 13),
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: copyText));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class VersionDialog extends StatelessWidget {
  String _version = '';
  String _buildNumber = '';

  //VersionDialog({Key? key}) : super(key: key);
  VersionDialog(String v, String b, {super.key}) {
    _version = v;
    _buildNumber = b;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Version:$_version\nBuildNumber:$_buildNumber',
        style: const TextStyle(fontSize: 13),
      ),

      /*
      content: Text(
        '',
        style: TextStyle(fontSize: 13),
      ),
      */
/*
      actions: <Widget>[
        GestureDetector(
          child: Text(
            'いいえ',
            style: TextStyle(fontSize: 13),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 13),
          ),
          onTap: () {
            //Clipboard.setData(ClipboardData(text: copyText));
            Navigator.pop(context);
          },
        )
      ],
      */
    );
  }
}

class MyRoulette extends StatelessWidget {
  const MyRoulette({
    Key? key,
    required this.controller,
  }) : super(key: key);

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
  const DialogKeyChange({Key? key}) : super(key: key);

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

  final icons = <IconData>[
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.accessibility,
    Icons.account_balance,
    Icons.account_balance_wallet,
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.accessibility,
    Icons.account_balance,
    Icons.account_balance_wallet,
  ];

  final images = <ImageProvider>[
    // Use [AssetImage] if you have 2.0x, 3.0x images,
    // We only have 1 exact image here
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://picsum.photos/seed/example1/400"),
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://bad.link.to.image"),
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://picsum.photos/seed/example5/400"),
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://picsum.photos/seed/example1/400"),
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://bad.link.to.image"),
    const ExactAssetImage("asset/gradient.jpg"),
    const NetworkImage("https://picsum.photos/seed/example5/400"),
    // MemoryImage(...)
    // FileImage(...)
    // ResizeImage(...)
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

    assert(colors.length == icons.length);
    //assert(colors.length == images.length);

/*
    _controller = RouletteController(
      vsync: this,
      group: RouletteGroup.uniformImages(
        colors.length,
        colorBuilder: (index) => colors[index],
        imageBuilder: (index) => images[index],
        textBuilder: (index) => texts[index],
        /*
        textBuilder: (index) {
          if (index == 0) return 'Hi';
          return '';
        },
        */
        styleBuilder: (index) {
          return const TextStyle(color: Colors.black, fontSize: 18);
        },
      ),
    );
    
        */
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
              /*
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Clockwise: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _clockwise,
                    onChanged: (onChanged) {
                      setState(() {
                        _controller.resetAnimation();
                        _clockwise = !_clockwise;
                      });
                    },
                  ),
                ],
              ),
              */
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
