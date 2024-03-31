library video_toolset_web;

import 'dart:async';
import 'dart:html';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_toolset_platform_interface/video_info.dart';
import 'package:video_toolset_platform_interface/video_toolset_platform_interface.dart';
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
  Future<String?> open({required String accept}) {
    final String id = 'input-${DateTime.now().millisecondsSinceEpoch}';

    final Completer<String?> completer = Completer();

    final InputElement uploadInput = (FileUploadInputElement() as InputElement)
      ..id = id
      ..draggable = true
      ..multiple = false
      ..accept = accept
      ..style.display = 'none';

    bool changeEventTriggered = false;

    void changeEventListener(e) async {
      if (changeEventTriggered) {
        return;
      }
      changeEventTriggered = true;

      final List<File> files = uploadInput.files ?? [];

      if (files.isEmpty) {
        completer.complete();
      } else {
        completer.complete(id);
      }
    }

    void cancelledEventListener(_) {
      completer.complete();
    }

    uploadInput.onChange.listen(changeEventListener);
    uploadInput.addEventListener('change', changeEventListener);
    uploadInput.addEventListener('cancel', cancelledEventListener);

    _inputContainer()?.children.add(uploadInput);
    uploadInput.click();

    return completer.future;
  }

  @override
  Future<void> close(String file) async {
    querySelector('#$file')?.remove();
  }

  @override
  Future<VideoInfo> getVideoInfo(String file) async {
    final ffprobe = FFprobeWorker();

    try {
      final input = querySelector('#$file') as InputElement;
      final files = input.files ?? [];
      if (files.isEmpty) {
        throw Exception('Input $file is empty');
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

  Element? _inputContainer() {
    return querySelector('#$_inputContainerId');
  }
}
