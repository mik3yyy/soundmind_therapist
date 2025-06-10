class Blog {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final String title;
  final String content;
  final String author;
  final int blogType;
  final int bLogStatus;
  final DateTime publishedAt;
  final String imageUrl;

  Blog({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.title,
    required this.content,
    required this.author,
    required this.blogType,
    required this.bLogStatus,
    required this.publishedAt,
    required this.imageUrl,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as int,
      timeCreated: DateTime.parse(json['timeCreated'] as String),
      timeUpdated: DateTime.parse(json['timeUpdated'] as String),
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      blogType: json['blogType'] as int,
      bLogStatus: json['bLogStatus'] as int,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'timeCreated': timeCreated.toIso8601String(),
        'timeUpdated': timeUpdated.toIso8601String(),
        'title': title,
        'content': content,
        'author': author,
        'blogType': blogType,
        'bLogStatus': bLogStatus,
        'publishedAt': publishedAt.toIso8601String(),
        'imageUrl': imageUrl,
      };
}
