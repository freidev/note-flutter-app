import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note/models/note.dart';
import 'package:note/providers/note_provider.dart';
import 'package:note/screens/note_editor.dart';
import 'package:note/utils/contants.dart';
import 'package:note/utils/styles.dart';
import 'package:note/widgets/calendar/horizontal_calendar.dart';
import 'package:note/widgets/layout/gap.dart';

class Home extends ConsumerStatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  const Home({super.key});
}

class _HomeState extends ConsumerState<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Note> notes = ref.watch(notesProvider);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search for notes',
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: grey600,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/svgs/search.svg'),
                        ),
                      ),
                    ),
                  ),
                  const Gap(padding, h: true),
                  SvgPicture.asset('assets/svgs/notification.svg')
                ],
              ),
              const Gap(padding),
              const HorizontalCalendar(),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Gap(12, h: true),
                  itemCount: notes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ChoiceChip(
                    onSelected: (value) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    label: Text(
                      notes[index].title,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: index == selectedIndex ? ligth : null,
                        fontWeight:
                            index == selectedIndex ? FontWeight.w600 : null,
                      ),
                    ),
                    selected: index == selectedIndex,
                  ),
                ),
              ),
              StaggeredGrid.count(
                crossAxisCount: 2,
                children: List.generate(
                  notes.length,
                  (index) {
                    final note = notes[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditor(
                            note: note,
                            onSaved: (note) {
                              ref.read(notesProvider.notifier).save(
                                    title: note.title,
                                    content: note.content,
                                  );
                            },
                          ),
                        ),
                      ),
                      child: CardNote(title: note.title, items: note.content),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEditor(
              onSaved: (note) {},
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        shape: const CircleBorder(),
        child: SvgPicture.asset('assets/svgs/add.svg'),
      ),
    );
  }
}

class CardNote extends StatelessWidget {
  final String title;
  final String items;

  const CardNote({Key? key, required this.title, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: colors[colorId()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
          Text(items),
          // for (var item in items) Text('• $item'),
        ],
      ),
    );
  }
}

int colorId() {
  var random = Random();
  return random.nextInt(5);
}
