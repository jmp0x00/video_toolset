library video_toolset;

import 'package:video_toolset_platform_interface/file_handler.dart';
import 'package:video_toolset_platform_interface/file_type.dart';
import 'package:video_toolset_platform_interface/video_info.dart';
import 'package:video_toolset_platform_interface/video_toolset_platform_interface.dart';

class VideoToolset {

  static VideoToolsetPlatform get platform => VideoToolsetPlatform.instance;

  Future<void> initialize() {
    return platform.initialize();
  }

  Future<void> dispose() {
    return platform.dispose();
  }

  Future<FileHandler> open({required FileType type}) {
    return platform.open(type: type);
  }

  Future<void> close(FileHandler file) {
    return platform.close(file);
  }

  Future<VideoInfo> getVideoInfo(FileHandler file) {
    return platform.getVideoInfo(file);
  }
}
