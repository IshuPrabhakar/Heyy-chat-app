
/// Story model to represent each story
class Story {
  final String url;
  final String date;
  final MediaType mediaType;
  final Duration duration;
  final String? caption;
  final String? text;

  const Story({
    required this.date,
    this.caption,
    required this.url,
    required this.mediaType,
    required this.duration,
    this.text
  });
}

enum MediaType {
  image,
  video,
  text,
}
