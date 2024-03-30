library video_toolset_io;

import 'package:video_toolset_platform_interface/file_handler.dart';
import 'package:video_toolset_platform_interface/file_type.dart';
import 'package:video_toolset_platform_interface/video_info.dart';
import 'package:video_toolset_platform_interface/video_toolset_platform_interface.dart';

class VideoToolsetPlugin extends VideoToolsetPlatform {

  static void registerWith() {
    VideoToolsetPlatform.instance = VideoToolsetPlugin();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    return super.initialize();
  }

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    return super.dispose();
  }

  @override
  Future<FileHandler> open({required FileType type}) {
    // TODO: implement open
    return super.open(type: type);
  }

  @override
  Future<void> close(FileHandler file) {
    // TODO: implement close
    return super.close(file);
  }

  @override
  Future<VideoInfo> getVideoInfo(FileHandler file) {
    // TODO: implement getVideoInfo
    return super.getVideoInfo(file);
  }
}
