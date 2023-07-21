class Content {
  String id;
  String title;
  String description;
  String? image;
  int order;

  Content(this.id, this.title, this.description, this.image, this.order);

  factory Content.fromJson(Map<String, dynamic> map) {
    return Content(
      map['_id'] as String,
      map['title'] as String,
      map['description'] as String,
      map['image'] as String?,
      map['order'] as int,
    );
  }
}
