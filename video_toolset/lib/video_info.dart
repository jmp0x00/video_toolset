import 'package:video_toolset/audio_info.dart';
import 'package:video_toolset/subtitles_info.dart';

class VideoInfo {
  final String title;
  final List<AudioInfo> audioStreams;
  final List<SubtitlesInfo> subtitlesStreams;

  VideoInfo({
    required this.title,
    required this.audioStreams,
    required this.subtitlesStreams,
  });
}
