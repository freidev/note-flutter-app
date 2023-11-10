import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/utils/styles.dart';
import 'package:note/widgets/layout/gap.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final ScrollController _scrollController = ScrollController();
  late List<DateTime> daysOfMonth;
  late int initialScrollIndex;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    daysOfMonth = List.generate(
      lastDayOfMonth.day,
      (index) => DateTime(now.year, now.month, index + 1),
    );
    initialScrollIndex = now.day - 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        double initialScrollOffset = initialScrollIndex * 60.0 + (4 * 2);
        _scrollController.jumpTo(initialScrollOffset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DateTime now = DateTime.now();
    // DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    // print(firstDayOfMonth);
    // DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    // List<DateTime> daysOfMonth = List.generate(
    //   lastDayOfMonth.day,
    //   (index) => DateTime(now.year, now.month, index + 1),
    // );

    return SizedBox(
      height: 120,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: daysOfMonth.length,
        itemBuilder: (context, index) {
          DateTime day = daysOfMonth[index];
          bool isSelected = day.day == now.day;

          return Container(
            width: 60.0,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: grey400, width: 1),
              color: isSelected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat('E').format(day), // Day name
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                const Gap(5.0),
                Text(
                  day.day.toString(), // Day number
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(5.0),
                Text(
                  DateFormat('MMM').format(day), // Month name
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
