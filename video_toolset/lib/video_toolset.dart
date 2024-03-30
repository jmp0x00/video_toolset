library video_toolset;

import 'package:video_toolset/file_handler.dart';
import 'package:video_toolset/video_info.dart';

abstract interface class VideoToolset<T> {
  Future<void> initialize();
  Future<void> dispose();

  Future<FileHandler<T>> open();
  Future<void> close(FileHandler<T> file);

  Future<VideoInfo> getVideoInfo(FileHandler<T> file);
}
