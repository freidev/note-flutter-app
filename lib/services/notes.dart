import 'dart:convert';

import 'package:http/http.dart';
import 'package:note/models/note.dart';
import 'package:note/services/http_service.dart';

HttpService httpService = HttpService();

class NoteServices {
  static Future<List<Note>> getNotes() async {
    Response response = await httpService.get('notes');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<Note> notes = List.from(body).map((e) => Note.fromMap(e)).toList();
      return notes;
    }
    return [];
  }

  static Future<Note> saveNote({
    required String title,
    required String content,
    String id = '',
  }) async {
    Map<String, dynamic> body = {};
    if (id.isEmpty) {
      Response response = await httpService.post('notes', {
        'title': title,
        'content': content,
      });
      body = json.decode(response.body);
    } else {
      Response response = await httpService.put('notes/$id', {
        'title': title,
        'content': content,
      });
      body = json.decode(response.body);
    }
    return Note.fromMap(body);
  }

  static Future<Note> getNoteById(String id) async {
    Response response = await httpService.get('notes/$id');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return Note.fromMap(body);
    }
    throw Exception('Note not found');
  }
}
