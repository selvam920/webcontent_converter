import 'dart:async';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/services.dart' show MethodChannel, rootBundle;
import '../../page.dart';

/// [WebcontentConverter] will convert html, html file, web uri, into raw bytes image or pdf file
class WebcontentConverter {
  static const MethodChannel _channel = const MethodChannel(
    'webcontent_converter',
  );

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// ## `WebcontentConverter.logger`
  /// `allow to pretty text`
  /// #### Example:
  /// ```
  /// WebcontentConverter.logger('Your log text', level: LevelMessages.info);
  /// ```
  static final logger = EasyLogger(
    name: 'webcontent_converter',
    defaultLevel: LevelMessages.debug,
    enableBuildModes: [BuildMode.debug, BuildMode.profile, BuildMode.release],
    enableLevels: [
      LevelMessages.debug,
      LevelMessages.info,
      LevelMessages.error,
      LevelMessages.warning,
    ],
  );

  static Future<void> ensureInitialized({
    String? executablePath,
    String? content,
  }) async {}

  static Future<void> initWebcontentConverter({
    String? executablePath,
    String? content,
  }) async {}

  static Future<void> deinitWebcontentConverter({
    bool isClosePage = true,
    bool isCloseBrower = true,
  }) async {
    ///
  }

  static Future<Uint8List> filePathToImage({
    required String path,
    double duration = 2000,
    String? executablePath,
    bool autoClosePage = true,
    int scale = 3,
  }) async {
    Uint8List result = Uint8List.fromList([]);
    try {
      String content = await rootBundle.loadString(path);

      result = await contentToImage(
        content: content,
        duration: duration,
        executablePath: executablePath,
        scale: scale,
      );
    } on Exception catch (e) {
      WebcontentConverter.logger.error("[method:filePathToImage]: $e");
      throw Exception("Error: $e");
    }
    return result;
  }

  static Future<Uint8List> webUriToImage({
    required String uri,
    double duration = 2000,
    String? executablePath,
    bool autoClosePage = true,
    int scale = 3,
  }) async {
    Uint8List result = Uint8List.fromList([]);
    try {
      var response = await Dio().get(uri);
      final String content = response.data.toString();
      result = await contentToImage(
        content: content,
        duration: duration,
        executablePath: executablePath,
        scale: scale,
      );
    } on Exception catch (e) {
      WebcontentConverter.logger.error("[method:webUriToImage]: $e");
      throw Exception("Error: $e");
    }
    return result;
  }

  static Future<Uint8List> contentToImage({
    required String content,
    double duration = 2000,
    String? executablePath,
    bool autoClosePage = true,
    int scale = 3,
  }) async {
    List<int> result = [];

    return Uint8List.fromList(result);
  }

  static Future<String?> filePathToPdf({
    required String path,
    double duration = 2000,
    required String savedPath,
    PdfMargins? margins,
    PaperFormat format = PaperFormat.a4,
    String? executablePath,
  }) async {
    var result;
    try {
      String content = await rootBundle.loadString(path);
      result = await contentToPDF(
        content: content,
        duration: duration,
        savedPath: savedPath,
        margins: margins,
        format: format,
        executablePath: executablePath,
      );
    } on Exception catch (e) {
      WebcontentConverter.logger.error("[method:filePathToPdf]: $e");
      throw Exception("Error: $e");
    }
    return result;
  }

  static Future<String?> webUriToPdf({
    required String uri,
    double duration = 2000,
    required String savedPath,
    PdfMargins? margins,
    PaperFormat format = PaperFormat.a4,
    String? executablePath,
  }) async {
    var result;
    try {
      var response = await Dio().get(uri);
      final String content = response.data.toString();
      result = await contentToPDF(
        content: content,
        duration: duration,
        savedPath: savedPath,
        margins: margins,
        format: format,
        executablePath: executablePath,
      );
    } on Exception catch (e) {
      WebcontentConverter.logger.error("[method:webUriToImage]: $e");
      throw Exception("Error: $e");
    }
    return result;
  }

  static Future<String?> contentToPDF({
    required String content,
    double duration = 2000,
    required String savedPath,
    PdfMargins? margins,
    PaperFormat format = PaperFormat.a4,
    String? executablePath,
    bool autoClosePage = true,
  }) async {
    return null;
  }

  static Future<bool> printPreview({
    String? url,
    String? content,
    bool autoClose = true,
    double? duration,
  }) async {
    return Future.value(false);
  }
}
