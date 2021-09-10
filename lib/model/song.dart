class Song {
  final String title;
  final String length;
  final int number;

  Song(this.title, this.length, this.number);

  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        length = json['length'],
        number = json['number'];
}