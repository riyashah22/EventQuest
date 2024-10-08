import 'dart:async';
import 'package:event_quest/models/event.dart';
import 'package:event_quest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:event_quest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:event_quest/screens/faculty_screens/event_screens/faculty_event_detail_screen.dart';
import 'package:event_quest/screens/faculty_screens/registration_screen/event_registration_screen.dart';
import 'package:event_quest/services/event_services.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class FacultyEventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const FacultyEventScreen({Key? key}) : super(key: key);

  @override
  State<FacultyEventScreen> createState() => _FacultyEventScreenState();
}

class _FacultyEventScreenState extends State<FacultyEventScreen> {
  int? _value;
  List<Event> events = [];
  EventServices eventServices = EventServices();

  Future<List<Event>> getAllPost() async {
    if (_value == 0) {
      events = await eventServices.getAllUgEvents(context);
    } else if (_value == 1) {
      events = await eventServices.getAllPgEvents(context);
    } else {
      events = await eventServices.getAllBothEvents(context);
    }

    return events;
  }

  @override
  void initState() {
    super.initState();
    getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Events",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Image.asset(
                  scale: 1,
                  height: 60,
                  width: 70,
                  "assets/images/event.gif",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          filterOption(context),
          // if (_value == 0)
          //   Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       children: [
          //         Expanded(
          //             child: Divider(
          //           height: 1,
          //           thickness: 2,
          //           color: appColors.primary,
          //         )),
          //         Expanded(
          //           flex: 4,
          //           child: Text(
          //             " Events For UG Only ",
          //             style: Theme.of(context).textTheme.titleLarge,
          //           ),
          //         ),
          //         Expanded(
          //           child: Divider(
          //             height: 1,
          //             thickness: 2,
          //             color: appColors.primary,
          //           ),
          //         )
          //       ],
          //     ),
          //   )
          // else if (_value == 1)
          //   Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       children: [
          //         Expanded(
          //             child: Divider(
          //           height: 1,
          //           thickness: 2,
          //           color: appColors.primary,
          //         )),
          //         Expanded(
          //           flex: 4,
          //           child: Text(
          //             " Events For PG Only ",
          //             style: Theme.of(context).textTheme.titleLarge,
          //           ),
          //         ),
          //         Expanded(
          //           child: Divider(
          //             height: 1,
          //             thickness: 2,
          //             color: appColors.primary,
          //           ),
          //         )
          //       ],
          //     ),
          //   )
          // else
          //   Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       // crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Expanded(
          //             child: Divider(
          //           height: 1,
          //           thickness: 2,
          //           color: appColors.primary,
          //         )),
          //         Expanded(
          //           flex: 4,
          //           child: Text(
          //             " Events For UG & PG ",
          //             style: Theme.of(context).textTheme.titleLarge,
          //           ),
          //         ),
          //         Expanded(
          //           child: Divider(
          //             height: 1,
          //             thickness: 2,
          //             color: appColors.primary,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          Expanded(
            child: FutureBuilder(
              future: getAllPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (events.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/noDataFound.gif',
                        height: 100,
                      ),
                      Text(
                        'No events found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  );
                } else {
                  events.sort((a, b) => b.eventRegistrationDeadline
                      .compareTo(a.eventRegistrationDeadline));
                  Map<String, List<Event>> groupedEvents = {};
                  events.forEach((event) {
                    String date = event.eventRegistrationDeadline.split("T")[0];
                    if (groupedEvents.containsKey(date)) {
                      groupedEvents[date]!.add(event);
                    } else {
                      groupedEvents[date] = [event];
                    }
                  });
                  return ListView(
                    children: groupedEvents.entries.map((entry) {
                      List<Event> eventsForDate = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: eventsForDate.length,
                            itemBuilder: (context, index) {
                              return buildEventCard(eventsForDate[index]);
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColors.primary,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddEventScreen.routeName,
          );
        },
        child: Icon(
          Icons.add,
          color: appColors.white,
        ),
      ),
    );
  }

  Widget buildEventCard(Event event) {
    final appColor = context.appColors;
    var date = event.eventRegistrationDeadline.split("T")[0];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xfffbfcf8),
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: GestureDetector(
                child: Image.network(
                  event.eventImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, FacultyEventDetailsScreen.routeName,
                      arguments: event);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date.split(" ")[0].split("-")[2],
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            month(int.parse(date.split("-")[1])),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.eventName,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          event.eventDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        height: 16,
                      ),
                      const SizedBox(width: 12),
                      Text('Edit',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, EditEventScreen.routeName,
                        arguments: event);
                  },
                ),
                const SizedBox(width: 60),
                const Text(
                  '|',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(width: 60),
                GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/delete.png',
                        height: 16,
                      ),
                      const SizedBox(width: 8),
                      Text('Delete',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: appColor.accent,
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                eventServices.deleteEvent(
                                  context: context,
                                  event: event,
                                  onSuccess: () {
                                    setState(() {
                                      events;
                                    });
                                  },
                                );
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                          title: Text('Confirm Deletion',
                              style: Theme.of(context).textTheme.bodyLarge),
                          content: const Text('Are you sure to delete Event?'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget filterOption(BuildContext context) {
    final appColor = context.appColors;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(EventRegistrationScreen.routeName);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 75),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.indigo,
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                    Color.fromARGB(255, 119, 109, 19),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: appColor.richBlack,
                  borderRadius:
                      BorderRadius.circular(8), // Match inner border radius
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Check Registrations',
                      style: TextStyle(
                        fontFamily: 'Brush Script MT',
                        fontSize: 16,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_sharp,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text('Select your preference',
              style: Theme.of(context).primaryTextTheme.labelLarge),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 20.0,
            children: List<Widget>.generate(
              2,
              (int index) {
                String optionText = 'UG';

                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;

                  default:
                    optionText = '';
                    break;
                }
                return ChoiceChip(
                  checkmarkColor: _value == index ? Colors.white : Colors.black,
                  backgroundColor: const Color(0xffE9F2F5),
                  selectedColor: const Color(0xff0B3F63),
                  label: Text(
                    optionText,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _value == index
                          ? Colors.white // Text color when selected
                          : Colors.black, // Text color when not selected
                    ),
                  ),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  String month(int? index) {
    switch (index) {
      case 00:
        return '';
      case 01:
        return 'Jan';
      case 02:
        return 'Feb';
      case 03:
        return 'Mar';
      case 04:
        return 'Apr';
      case 05:
        return 'May';
      case 06:
        return 'Jun';
      case 07:
        return 'Jul';
      case 08:
        return 'Aug';
      case 09:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';

      default:
        return '';
    }
  }
}
