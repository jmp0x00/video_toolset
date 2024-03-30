@JS('ffmpeg')
library ffmpeg;

import 'dart:js_interop';
import 'dart:js_util';
import 'dart:typed_data';

extension type FFmpeg._(JSObject _) implements JSObject {
  external FFmpeg();

  void onLog(LogEventCallback callback) {
    _on('log'.toJS, callback.toJS);
  }

  void onProgress(ProgressEventCallback callback) {
    _on('progress'.toJS, callback.toJS);
  }

  void offLog(LogEventCallback callback) {
    _off('log'.toJS, callback.toJS);
  }

  void offProgress(ProgressEventCallback callback) {
    _off('progress'.toJS, callback.toJS);
  }

  Future<bool> load(FFMessageLoadConfig config) {
    return promiseToFuture<JSBoolean>(_load(config)).then((value) => value.toDart);
  }

  Future<int> exec(List<String> args, {int timeout = -1}) {
    final jsArgs = args.map((arg) => arg.toJS).toList().toJS;
    return promiseToFuture<JSNumber>(_exec(jsArgs, timeout.toJS)).then((value) => value.toDartInt);
  }

  Future<bool> writeFile(String path, Uint8List fileData) {
    return promiseToFuture<JSBoolean>(_writeFile(path.toJS, fileData.toJS)).then((value) => value.toDart);
  }

  Future<bool> deleteFile(String path) {
    return promiseToFuture<JSBoolean>(_deleteFile(path.toJS)).then((value) => value.toDart);
  }

  Future<Uint8List> readFile(String path) {
    return promiseToFuture<JSUint8Array>(_readFile(path.toJS)).then((value) => value.toDart);
  }

  void terminate() {
    _terminate();
  }

  @JS('load')
  external JSPromise<JSBoolean> _load(FFMessageLoadConfig config);

  @JS('exec')
  external JSPromise<JSNumber> _exec(JSArray<JSString> args, JSNumber timeout);

  @JS('writeFile')
  external JSPromise<JSNumber> _writeFile(JSString path, JSUint8Array fileData);

  @JS('deleteFile')
  external JSPromise<JSBoolean> _deleteFile(JSString path);

  @JS('readFile')
  external JSPromise<JSUint8Array> _readFile(JSString path);

  @JS('on')
  external void _on(JSString event, JSFunction callback);

  @JS('off')
  external void _off(JSString event, JSFunction callback);

  @JS('terminate')
  external void _terminate();
}

extension type LogEvent._(JSObject _) implements JSObject {
  external String get type;

  external String get message;
}

extension type ProgressEvent._(JSObject _) implements JSObject {
  external num get progress;

  external num get time;
}

typedef LogEventCallback = void Function(LogEvent);
typedef ProgressEventCallback = void Function(ProgressEvent);

extension type FFMessageLoadConfig._(JSObject _) implements JSObject {
  external FFMessageLoadConfig({
    String? coreURL,
    String? wasmURL,
    String? workerURL,
    String? classWorkerURL,
  });

  external String? get coreURL;

  external String? get wasmURL;

  external String? get workerURL;

  external String? get classWorkerURL;
}
