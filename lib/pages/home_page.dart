import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reminders/utils/hex_color.dart';

import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> titles = [
    "Coffee",
    "Certification",
    "Team Meeting",
    "Birthday Party Preparations",
    "",
    "Appointment",
    "Grocery",
    "Anniversary"
  ];
  List<String> content = [
    "Prepare hot coffee for friends.",
    "Call instructor",
    "Planning sprint log for next product design update",
    "",
    "Buy tickets for the family vacations",
    "Health check up.",
    "",
    "Send best wishes."
  ];
  List<String> dates = [
    "Today, 4:30",
    "Today, 8:45",
    "Tomorrow, 11:15",
    "Sat, 6:00",
    "4 Sep, 3:00",
    "5 Sep, 5:00",
    "9 Sep, 4:00",
    "11 Nov, 9:00"
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
          onPressed: () {},
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
                    return NoteWidget(
                        title: titles[index],
                        content: content[index],
                        date: dates[index]);
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
                      return NoteWidget(
                          title: titles[index + 2],
                          content: content[index + 2],
                          date: dates[index + 2]);
                    }),
              )
            ],
          ),
        ));
  }
}
