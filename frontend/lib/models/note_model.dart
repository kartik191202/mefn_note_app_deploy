import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String? noteId;
  final String? title;
  final String? description;
  final num? createdAt;
  final String? creatorId;

  const NoteModel(
      {this.noteId,
      this.title,
      this.description,
      this.createdAt,
      this.creatorId});

  factory NoteModel.fromjson(Map<String, dynamic> json) {
    return NoteModel(
      noteId: json['_id'],
      title: json['title'],
      createdAt: json['createdAt'],
      description: json['description'],
      creatorId: json['creatorId'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "noteId": noteId,
      "title": title,
      "createdAt": createdAt,
      "description": description,
      "creatorId": creatorId
    };
  }

  @override
  List<Object?> get props => [noteId, title, createdAt, description, creatorId];
}
