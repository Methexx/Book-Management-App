class Book {
  String id;
  String title;
  String author;
  String description;
  DateTime dateAdded;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.dateAdded,
  });

  // Convert a Book object to a F irestore Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  // Convert Firestore Map to Book object
  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      id: documentId,
      title: map['title'],
      author: map['author'],
      description: map['description'],
      dateAdded: DateTime.parse(map['dateAdded']),
    );
  }
}
