@JS('ffprobe')
library ffprobe;

import 'dart:html';
import 'dart:js_interop';
import 'dart:js_util';

extension type FFprobeWorker._(JSObject _) implements JSObject {
  external FFprobeWorker();

  Future<FileInfo> getFileInfo(File file) {
    return promiseToFuture<FileInfo>(_getFileInfo(file as JSAny));
  }

  Future<FramesInfo> getFrames(File file, {int offset = 0}) {
    return promiseToFuture<FramesInfo>(_getFrames(file as JSAny, offset.toJS));
  }

  void terminate() {
    _terminate();
  }

  @JS('getFileInfo')
  external JSPromise<FileInfo> _getFileInfo(JSAny file);

  @JS('getFrames')
  external JSPromise<FramesInfo> _getFrames(JSAny file, JSNumber offset);

  @JS('terminate')
  external void _terminate();
}

extension type FileInfo._(JSObject _) implements JSObject {
  external JSArray<StreamInfo> get streams;

  external JSArray<Chapter> get chapters;

  external Format get format;
}

extension type Format._(JSObject _) implements JSObject {
  external String get filename;

  @JS('nb_streams')
  external int get nbStreams;

  @JS('nb_programs')
  external int get nbPrograms;

  @JS('format_name')
  external String get formatName;

  @JS('format_long_name')
  external String get formatLongName;

  @JS('start_time')
  external String get startTime;

  external String get duration;

  external String get size;

  @JS('bit_rate')
  external String get bitRate;

  @JS('probe_score')
  external int get probeScore;

  external JSObject get tags;
}

@JS('Stream')
extension type StreamInfo._(JSObject _) implements JSObject {
  external int get index;
  @JS('codec_name')
  external String get codecName;
  @JS('codec_long_name')
  external String get codecLongName;
  external String get profile;
  @JS('codec_type')
  external String get codecType;
  @JS('codec_tag_string')
  external String get codecTagString;
  @JS('codec_tag')
  external String get codecTag;
  external int get width;
  external int get height;
  @JS('codec_width')
  external int get codecWidth;
  @JS('codec_height')
  external int get codecHeight;
  @JS('closed_captions')
  external int get closedCaptions;
  @JS('has_b_frames')
  external int get hasBFrames;
  @JS('pix_fmt')
  external String get pixFmt;
  external int get level;
  @JS('color_range')
  external String get colorRange;
  @JS('color_primaries')
  external String get colorPrimaries;
  @JS('chroma_location')
  external String get chromaLocation;
  external int get refs;
  @JS('is_avc')
  external String get isAvc;
  @JS('nal_length_size')
  external String get nalLengthSize;
  @JS('sample_fmt')
  external String get sampleFmt;
  @JS('sample_rate')
  external String get sampleRate;
  external int get channels;
  @JS('channel_layout')
  external String get channelLayout;
  @JS('bits_per_sample')
  external int get bitsPerSample;
  @JS('r_frame_rate')
  external String get rFrameRate;
  @JS('avg_frame_rate')
  external String get avgFrameRate;
  @JS('time_base')
  external String get timeBase;
  @JS('start_pts')
  external int get startPts;
  @JS('start_time')
  external String get startTime;
  @JS('duration_ts')
  external int get durationTs;
  external String get duration;
  @JS('bit_rate')
  external String get bitRate;
  @JS('bits_per_raw_sample')
  external String get bitsPerRawSample;
  @JS('nb_frames')
  external String get nbFrames;
  external Disposition get disposition;
  external JSObject tags;
}

extension type Disposition._(JSObject _) implements JSObject {
  @JS('default')
  external int get def;
  external int get dub;
  external int get original;
  external int get comment;
  external int get lyrics;
  external int get karaoke;
  external int get forced;
  @JS('hearing_impaired')
  external int get hearingImpaired;
  @JS('visual_impaired')
  external int get visualImpaired;
  @JS('clean_effects')
  external int get cleanEffects;
  @JS('attached_pic')
  external int get attachedPic;
  @JS('timed_thumbnails')
  external int get timedThumbnails;
}

extension type FramesInfo._(JSObject _) implements JSObject {
  @JS('avg_frame_rate')
  external int get avgFrameRate;
  external int get duration;
  external JSArray<Frame> get frames;
  @JS('gop_size')
  external int get gopSize;
  @JS('nb_frames')
  external int get nbFrames;
  @JS('time_base')
  external int get timeBase;
}

extension type Frame._(JSObject _) implements JSObject {
  external int get dts;
  @JS('frame_number')
  external int get frameNumber;
  @JS('pict_type')
  external int get pictType;
  @JS('pkt_size')
  external int get pktSize;
  external int get pos;
  external int get pts;
}

extension type Chapter._(JSObject _) implements JSObject {
  external int get end;
  external int get id;
  external JSObject get tags;
  external int get start;
  @JS('time_base')
  external String get timeBase;
}
