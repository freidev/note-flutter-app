import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note/models/note.dart';
import 'package:note/services/notes.dart';
import 'package:note/utils/contants.dart';
import 'package:note/utils/styles.dart';
import 'package:note/widgets/calendar/horizontal_calendar.dart';
import 'package:note/widgets/layout/gap.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notes = [];
  Future<void> getNotes() async {
    try {
      notes = await NoteServices.getNotes();
      setState(() {});
    } catch (e) {
      print('e $e');
    }
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('hello workd');
    final theme = Theme.of(context);
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: padding,
      crossAxisSpacing: padding,
      mainAxisExtent: 250.0,
    );
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
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ChoiceChip(
                    label: const Text('Today'),
                    selected: index == 0,
                  ),
                ),
              ),
              StaggeredGrid.count(
                crossAxisCount: 2,
                children: List.generate(
                  notes.length,
                  (index) {
                    final note = notes[index];
                    return CardNote(title: note.title, items: note.content);
                  },
                ),
              )
              // ...List.generate(
              //   notes.length,
              //   (index) {
              //     return const Row(
              //       children: [
              //         Expanded(
              //           child: CardNote(
              //             title: 'Product Meeting',
              //             items: 'Hug x Hug vious.',
              //           ),
              //         ),
              //         Expanded(
              //           child: CardNote(
              //             title: 'To-do list',
              //             items:
              //                 'Prepare presentation slides for the marketing meeting',
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // )
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: gridDelegate,
              //     itemBuilder: (context, index) {
              //       final note = notes[index];
              //       return CardNote(
              //         title: note.title,
              //         items: note.content,
              //       );
              //       // return Container(
              //       //   padding: const EdgeInsets.all(padding),
              //       //   decoration: BoxDecoration(
              //       //     color: Colors.blue.shade200,
              //       //     borderRadius: BorderRadius.circular(20.0),
              //       //   ),
              //       //   child: Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.start,
              //       //     children: [
              //       //       Text(
              //       //         note.title,
              //       //         style: theme.textTheme.titleMedium,
              //       //       ),
              //       //       Text(note.content),
              //       //     ],
              //       //   ),
              //       // );
              //     },
              //     itemCount: notes.length,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
