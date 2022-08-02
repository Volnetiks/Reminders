import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:reminders/pages/home_page.dart';
import 'package:reminders/utils/date_utils.dart';

import '../database/notes_database.dart';
import '../models/note.dart';
import '../utils/hex_color.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool pinned = false;
  bool notificationsEnabled = false;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final timeController = TextEditingController();
  final dayController = TextEditingController();

  DateTime? day;
  TimeOfDay? time;

  int colorID = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 100,
          child: BottomAppBar(
              color: Colors.white,
              notchMargin: 7,
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            colorID = 0;
                          });
                        },
                        icon: Icon(
                            colorID == 0
                                ? Icons.check_box_rounded
                                : Icons.square_rounded,
                            color: HexColor.fromHex("#ffa447"),
                            size: 50)),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            colorID = 1;
                          });
                        },
                        icon: Icon(
                            colorID == 1
                                ? Icons.check_box_rounded
                                : Icons.square_rounded,
                            color: HexColor.fromHex("#7ecbff"),
                            size: 50)),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            colorID = 2;
                          });
                        },
                        icon: Icon(
                            colorID == 2
                                ? Icons.check_box_rounded
                                : Icons.square_rounded,
                            color: HexColor.fromHex("#ffa6c4"),
                            size: 50)),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            colorID = 3;
                          });
                        },
                        icon: Icon(
                            colorID == 3
                                ? Icons.check_box_rounded
                                : Icons.square_rounded,
                            color: HexColor.fromHex("#1eccc3"),
                            size: 50)),
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            colorID = 4;
                          });
                        },
                        icon: Icon(
                            colorID == 4
                                ? Icons.check_box_rounded
                                : Icons.square_rounded,
                            color: HexColor.fromHex("#ffa3a3"),
                            size: 50)),
                  ],
                ),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.check_rounded,
              color: HexColor.fromHex("#f7a243"), size: 40),
          onPressed: () async {
            if (titleController.text.isNotEmpty ||
                contentController.text.isNotEmpty) {
              if (day != null && time != null) {
                NotesDatabase.instance.createNote(Note(
                    title: titleController.text.isNotEmpty
                        ? titleController.text
                        : "",
                    content: contentController.text.isNotEmpty
                        ? contentController.text
                        : "",
                    colorID: colorID,
                    dueDate: DateTime(day!.year, day!.month, day!.day,
                        time!.hour, time!.minute),
                    isDone: false,
                    isPinned: pinned,
                    notifications: notificationsEnabled));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false);
              }
            }
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: Icon(pinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: Colors.black),
              onPressed: () {
                setState(() {
                  pinned = !pinned;
                });
              },
            ),
            IconButton(
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                  notificationsEnabled
                      ? Icons.notifications
                      : Icons.notifications_outlined,
                  color: Colors.black),
              onPressed: () {
                setState(() {
                  notificationsEnabled = !notificationsEnabled;
                });
              },
            ),
            IconButton(
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(Icons.access_time, color: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text('When to remind?'),
                          actions: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor.fromHex("#edf1f3"),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: TextField(
                                    controller: dayController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        suffixIcon: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: () async {
                                            final DateTime? picked =
                                                await showDialog<DateTime>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AwesomeCalendarDialog(
                                                  startDate: DateTime.now(),
                                                  selectionMode:
                                                      SelectionMode.single,
                                                  canToggleRangeSelection:
                                                      false,
                                                );
                                              },
                                            );

                                            setState(() {
                                              if (picked != null) {
                                                day = picked;
                                                dayController.text =
                                                    picked.formatDatePicker();
                                              }
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month),
                                        ),
                                        hintText: "Day",
                                        contentPadding:
                                            const EdgeInsets.all(15))),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor.fromHex("#edf1f3"),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: TextField(
                                    controller: timeController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        suffixIcon: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(showPicker(
                                                    context: context,
                                                    value: TimeOfDay.now(),
                                                    onChange: (value) => {
                                                          setState(() {
                                                            timeController
                                                                    .text =
                                                                value.format(
                                                                    context);
                                                            time = value;
                                                          })
                                                        }));
                                          },
                                          icon: const Icon(Icons.access_time),
                                        ),
                                        hintText: "Time",
                                        contentPadding:
                                            const EdgeInsets.all(15))),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        elevation: 0,
                                        primary: Colors.white,
                                        onPrimary: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          day = null;
                                          time = null;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel",
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 80,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 0,
                                          primary: HexColor.fromHex("#ffa447"),
                                          onPrimary: Colors.black),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Save")),
                                ),
                              ],
                            ),
                          ],
                        ));
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              TextField(
                  controller: titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                          color: HexColor.fromHex("#343a50"),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                  style: TextStyle(
                      color: HexColor.fromHex("#343a50"),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              TextField(
                  controller: contentController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: "Content",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                      border: InputBorder.none),
                  style: const TextStyle(fontSize: 20, color: Colors.black))
            ],
          ),
        ));
  }
}
