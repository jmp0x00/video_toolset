library video_toolset_io;

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
  Future<String?> open({required String accept}) {
    // TODO: implement open
    return super.open(accept: accept);
  }

  @override
  Future<void> close(String file) {
    // TODO: implement close
    return super.close(file);
  }

  @override
  Future<VideoInfo> getVideoInfo(String file) {
    // TODO: implement getVideoInfo
    return super.getVideoInfo(file);
  }
}
