import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note/models/note.dart';
import 'package:note/providers/note_provider.dart';
import 'package:note/utils/contants.dart';
import 'package:note/utils/styles.dart';
import 'package:note/widgets/layout/gap.dart';

class NoteEditor extends ConsumerStatefulWidget {
  final Note? note;
  final Function(Note note) onSaved;
  const NoteEditor({super.key, this.note, required this.onSaved});

  @override
  _NoteEditorState createState() => _NoteEditorState();
  // _NoteEditorState createState() => _NoteEditorState();
  // ConsumerState<ConsumerStatefulWidget> createState() => _NoteEditorState();
  // @override
  // State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends ConsumerState<NoteEditor> {
  final QuillController _controller = QuillController.basic();
  late FocusNode _focusNode;
  final TextEditingController _title = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    if (widget.note != null) {
      _title.text = widget.note!.title;
      final document = Document()..insert(0, widget.note!.content);
      _controller.document = document;
    }
  }

  void saveNote() async {
    ref.read(notesProvider.notifier).save(
          title: _title.text,
          content: _controller.plainTextEditingValue.text,
          id: widget.note?.id ?? '',
        );
  }

  @override
  void deactivate() {
    saveNote();
    super.deactivate();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/copy.svg'),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svgs/heart.svg'),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset('assets/svgs/share.svg'),
            onPressed: () {},
          ),
          const Gap(10.0, h: true),
        ],
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: const QuillSharedConfigurations(
            locale: Locale('es'),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: TextFormField(
                controller: _title,
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: theme.textTheme.headlineMedium!.copyWith(
                    color: grey600.withOpacity(.5),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Expanded(
              child: QuillEditor.basic(
                configurations: const QuillEditorConfigurations(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  readOnly: false,
                ),
              ),
            ),
            const SafeArea(
              child: QuillToolbar(
                configurations: QuillToolbarConfigurations(
                  // showDividers: false,
                  showAlignmentButtons: false,
                  showBackgroundColorButton: false,
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text('Save'),
      // ),
    );
  }
}
