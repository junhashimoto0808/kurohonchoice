import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class ZipUploader extends StatefulWidget {
  @override
  _ZipUploaderState createState() => _ZipUploaderState();
}

class _ZipUploaderState extends State<ZipUploader> {
  File? _zipFile;
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _checkUploadedZip(); // 起動時にZIPファイルの存在確認
  }

  // ZIPファイルの存在確認
  Future<void> _checkUploadedZip() async {
    final appDir = await getApplicationDocumentsDirectory();
    final zipPath = File('${appDir.path}/uploaded.zip');

    if (await zipPath.exists()) {
      print("既存のZIPファイルが見つかりました: ${zipPath.path}");
      setState(() {
        _zipFile = zipPath;
      });
    } else {
      print("ZIPファイルは存在しません。");
      setState(() {
        _zipFile = null;
      });
    }
  }

  // ZIPファイルの選択と保存
  Future<void> _pickZipFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip'],
      );

      if (result != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final zipPath = File('${appDir.path}/uploaded.zip');

        // ZIPファイルを保存
        final selectedFile = File(result.files.single.path!);
        await selectedFile.copy(zipPath.path);

        print("ZIPファイルが保存されました: ${zipPath.path}");

        setState(() {
          _zipFile = zipPath;
        });

        // 解凍処理を即時実行
        await _extractZip(zipPath);
      } else {
        print("ZIPファイルの選択がキャンセルされました。");
      }
    } catch (e, stackTrace) {
      print("エラーが発生しました: $e");
      print("スタックトレース: $stackTrace");
    }
  }

  // ZIPファイルを解凍
  Future<void> _extractZip(File zipFile) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/images');

      // ディレクトリを作成
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
        print("ディレクトリを作成しました: ${imagesDir.path}");
      }

      final bytes = zipFile.readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      final List<String> supportedExtensions = [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'bmp',
        'webp'
      ];

      List<File> images = [];
      for (final file in archive) {
        if (!file.isFile) continue;

        // サブフォルダを無視してファイル名を取得
        final sanitizedFileName = file.name.split('/').last;

        // 隠しファイル（ドットで始まるファイル）をスキップ
        if (sanitizedFileName.startsWith('.')) {
          print("隠しファイルをスキップ: $sanitizedFileName");
          continue;
        }

        final fileExtension = sanitizedFileName.split('.').last.toLowerCase();

        if (supportedExtensions.contains(fileExtension)) {
          final outputFile = File('${imagesDir.path}/$sanitizedFileName');
          await outputFile.writeAsBytes(file.content as List<int>);
          print("保存されたファイル: ${outputFile.path}");
          images.add(outputFile);
        }
      }

      // 解凍後のファイルを確認
      final savedFiles = imagesDir.listSync();
      print("保存されたファイル一覧: ${savedFiles.map((e) => e.path).toList()}");

      setState(() {
        _images = images;
      });
    } catch (e, stackTrace) {
      print("解凍中にエラーが発生しました: $e");
      print("スタックトレース: $stackTrace");
    }
  }

  // ZIPファイルの削除（解凍済みファイルも含む）
  Future<void> _deleteZipFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    final zipPath = File('${appDir.path}/uploaded.zip');
    final extractedDir = Directory('${appDir.path}/images'); // 解凍先ディレクトリ

    // ZIPファイルの削除
    if (await zipPath.exists()) {
      await zipPath.delete();
      print("ZIPファイルを削除しました: ${zipPath.path}");
    }

    // 解凍済みファイルのディレクトリを削除
    if (await extractedDir.exists()) {
      await extractedDir.delete(recursive: true);
      print("解凍済みのファイルを削除しました: ${extractedDir.path}");
    }

    // 状態をリセット
    setState(() {
      _zipFile = null;
      _images = [];
    });
  }

  Future<void> _showDeleteConfirmationDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: Text('本当に削除してよろしいですか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // キャンセル
              child: Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // OK
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    // OKを押した場合に削除を実行
    if (confirmed == true) {
      await _deleteZipFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ZIPアップローダー')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_zipFile != null) ...[
              Text('アップロード済みZIP: ${_zipFile!.path.split('/').last}'),
              ElevatedButton(
                onPressed: _showDeleteConfirmationDialog, // 確認ダイアログを表示
                child: Text('ZIPを削除'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: _pickZipFile, // ZIPを選択
                child: Text('ZIPを選択'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
