library video_toolset;

import 'package:video_toolset_platform_interface/video_info.dart';
import 'package:video_toolset_platform_interface/video_toolset_platform_interface.dart';
import 'package:video_toolset/file_type.dart';

class VideoToolset {

  static VideoToolsetPlatform get platform => VideoToolsetPlatform.instance;

  Future<void> initialize() {
    return platform.initialize();
  }

  Future<void> dispose() {
    return platform.dispose();
  }

  Future<String?> open({required FileType type}) {
    return platform.open(accept: _fileTypeToAccept(type));
  }

  Future<void> close(String file) {
    if (file.isEmpty) {
      throw Exception('File is empty');
    }
    return platform.close(file);
  }

  Future<VideoInfo> getVideoInfo(String file) {
    if (file.isEmpty) {
      throw Exception('File is empty');
    }
    return platform.getVideoInfo(file);
  }

  String _fileTypeToAccept(FileType type) {
    switch (type) {
      case FileType.video:
        return 'video/*';
      case FileType.audio:
        return 'audio/*';
      case FileType.subtitles:
        return 'image/*';
    }
  }
}
