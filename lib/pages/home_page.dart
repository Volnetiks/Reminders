import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/pages/note_page.dart';
import 'package:reminders/utils/hex_color.dart';

import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> pinnedNotes = [
    Note(
        colorID: 1,
        content: "Prepare hot coffee for friends.",
        title: "Coffee",
        isPinned: true,
        dueDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 16, 30)),
    Note(
        colorID: 0,
        content: "Call instructor",
        title: "Certification",
        isPinned: true,
        dueDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 20, 45)),
  ];

  List<Note> notes = [
    Note(
        colorID: 2,
        content: "Planning sprint log for next product design update",
        title: "Team Meeting",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 1, 11, 15)),
    Note(
        colorID: 3,
        content: "",
        title: "Birthday Party Preparations",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 3, 18, 00)),
    Note(
        colorID: 3,
        content: "Buy tickets for the family vacations",
        title: "",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.september, 4, 15, 00)),
    Note(
        colorID: 4,
        content: "Health check up.",
        title: "Appointment",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.september, 5, 9, 00)),
    Note(
        colorID: 0,
        content: "",
        title: "Grocery",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.september, 9, 4, 00)),
    Note(
        colorID: 1,
        content: "Send best wishes.",
        title: "Anniversary",
        isPinned: false,
        dueDate: DateTime(DateTime.now().year, DateTime.november, 11, 18, 00)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Opacity(
          opacity: 0.95,
          child: BottomAppBar(
              color: Colors.white,
              elevation: 0.1,
              notchMargin: 10,
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.list, size: 35)),
                    const SizedBox(height: 60.0),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, size: 35)),
                  ],
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add_rounded,
              color: HexColor.fromHex("#f7a243"), size: 40),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NotePage();
            }));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.person, size: 60)),
              Text("Reminders",
                  style: TextStyle(
                      color: HexColor.fromHex("#343a50"),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Text("Pinned",
                  style: TextStyle(
                      color: HexColor.fromHex("#bdbfc3"), fontSize: 15)),
              SizedBox(
                height: 190,
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return NoteWidget(note: pinnedNotes[index]);
                  },
                ),
              ),
              Text("Upcoming",
                  style: TextStyle(
                      color: HexColor.fromHex("#bdbfc3"), fontSize: 15)),
              Expanded(
                child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return NoteWidget(note: notes[index]);
                    }),
              )
            ],
          ),
        ));
  }
}
