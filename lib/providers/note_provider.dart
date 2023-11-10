import 'package:note/models/note.dart';
import 'package:note/services/notes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_provider.g.dart';

@riverpod
class Notes extends _$Notes {
  @override
  List<Note> build() {
    List<Note> notes = [];
    NoteServices.getNotes().then((value) {
      state = value;
    });
    return notes;
  }

  void save({
    required String title,
    required String content,
    String id = '',
  }) async {
    Note note = await NoteServices.saveNote(
      title: title,
      content: content,
      id: id,
    );
    if (id.isEmpty) {
      state = [...state, note];
    } else {
      final index = state.indexWhere((element) => element.id == id);
      state[index] = note;
    }
  }
}
