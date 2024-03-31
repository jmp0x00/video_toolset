library video_toolset_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:video_toolset_platform_interface/video_info.dart';

abstract class VideoToolsetPlatform extends PlatformInterface {
  VideoToolsetPlatform() : super(token: _token);

  static final Object _token = Object();

  static VideoToolsetPlatform _instance = _PlaceholderImplementation();

  static VideoToolsetPlatform get instance => _instance;

  static set instance(VideoToolsetPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<void> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> dispose() {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Future<String?> open({required String accept}) {
    throw UnimplementedError('open() has not been implemented.');
  }

  Future<void> close(String file) {
    throw UnimplementedError('close() has not been implemented.');
  }

  Future<VideoInfo> getVideoInfo(String file) {
    throw UnimplementedError('getVideoInfo() has not been implemented.');
  }
}

class _PlaceholderImplementation extends VideoToolsetPlatform {}
