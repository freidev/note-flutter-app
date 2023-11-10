import 'dart:convert';

import 'package:http/http.dart';
import 'package:note/models/note.dart';
import 'package:note/services/http_service.dart';

class NoteServices {
  static Future<List<Note>> getNotes() async {
    HttpService httpService = HttpService();
    print('object');
    Response response = await httpService.get('notes');
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<Note> notes = List.from(body).map((e) => Note.fromMap(e)).toList();
      return notes;
      // print('notes $notes');
      // for (var item in body as List) {
      //   Note note = Note.fromMap(item);
      //   print('note $note');
      // }
      // List<Note> notes = noteFromJson(response.body);
      // print(response.body);
      // return noteFromJson(response.body);
    }
    return [];
  }
}
