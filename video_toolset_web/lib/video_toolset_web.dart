library video_toolset_web;

import 'dart:async';
import 'dart:html';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_toolset_platform_interface/file_handler.dart';
import 'package:video_toolset_platform_interface/file_type.dart';
import 'package:video_toolset_platform_interface/video_info.dart';
import 'package:video_toolset_platform_interface/video_toolset_platform_interface.dart';
import 'package:video_toolset_web/web_file_handler.dart';
import 'package:video_toolset_web/ffprobe.dart';

class VideoToolsetPlugin extends VideoToolsetPlatform {
  static const String _inputContainerId = '__video-toolset-container';

  static void registerWith(Registrar registrar) {
    VideoToolsetPlatform.instance = VideoToolsetPlugin();
  }

  @override
  Future<void> initialize() async {
    final Element targetElement = Element.tag('div')
      ..id = _inputContainerId
      ..style.display = 'none';
    querySelector('body')?.children.add(targetElement);
  }

  @override
  Future<void> dispose() async {
    _inputContainer()?.remove();
  }

  @override
  Future<FileHandler> open({required FileType type}) {
    final String id = DateTime.now().toString();

    final Completer<FileHandler> completer = Completer<FileHandler>();

    final InputElement uploadInput = (FileUploadInputElement() as InputElement)
      ..id = id
      ..draggable = true
      ..multiple = false
      ..accept = _fileType(type)
      ..style.display = 'none';

    bool changeEventTriggered = false;

    void changeEventListener(e) async {
      if (changeEventTriggered) {
        return;
      }
      changeEventTriggered = true;

      final List<File> files = uploadInput.files ?? [];

      if (files.isEmpty) {
        completer.complete(EmptyFileHandler());
      } else {
        completer.complete(WebFileHandler(id: id));
      }
    }

    void cancelledEventListener(_) {
      completer.complete(EmptyFileHandler());
    }

    uploadInput.onChange.listen(changeEventListener);
    uploadInput.addEventListener('change', changeEventListener);
    uploadInput.addEventListener('cancel', cancelledEventListener);

    return completer.future;
  }

  @override
  Future<void> close(FileHandler file) async {
    if (file is EmptyFileHandler) {
      return;
    }
    if (file is WebFileHandler) {
      querySelector('#${file.id}')?.remove();
    }
  }

  @override
  Future<VideoInfo> getVideoInfo(FileHandler file) async {
    if (file is WebFileHandler) {
      return await _getVideoInfo(file);
    } else if (file is EmptyFileHandler) {
      throw Exception('Cannot get video information from empty file');
    } else {
      throw Exception('Cannot get video information from unknown type of file');
    }
  }

  Future<VideoInfo> _getVideoInfo(WebFileHandler file) async {
    final ffprobe = FFprobeWorker();

    try {
      final input = querySelector(file.id) as InputElement;
      final files = input.files ?? [];
      if (files.isEmpty) {
        throw Exception('Input ${file.id} is empty');
      }

      final fileInfo = await ffprobe.getFileInfo(files.first);
      final title = fileInfo.format.tags.getProperty<JSString?>('title'.toJS)?.toDart ?? '';

      return VideoInfo(
        title: title,
        audioStreams: [],
        subtitlesStreams: [],
      );
    } finally {
      ffprobe.terminate();
    }
  }

  String _fileType(FileType type) {
    switch (type) {
      case FileType.video:
        return 'video/*';
      case FileType.audio:
        return 'audio/*';
      case FileType.subtitles:
        return 'image/*';
    }
  }

  Element? _inputContainer() {
    return querySelector('#$_inputContainerId');
  }
}
