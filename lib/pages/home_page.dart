import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/pages/note_page.dart';
import 'package:reminders/utils/hex_color.dart';

import '../database/notes_database.dart';
import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> pinnedNotes;
  late List<Note> notes;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    notes = await NotesDatabase.instance.readNonPinnedNotes();
    pinnedNotes = await NotesDatabase.instance.readPinnedNotes();

    setState(() {
      isLoading = false;
    });
  }

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
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notes.isEmpty
                ? const Center(
                    child: Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : Padding(
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
                        pinnedNotes.isEmpty
                            ? Container()
                            : Text("Pinned",
                                style: TextStyle(
                                    color: HexColor.fromHex("#bdbfc3"),
                                    fontSize: 15)),
                        pinnedNotes.isEmpty
                            ? Container()
                            : SizedBox(
                                height: 190,
                                child: MasonryGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 15,
                                  itemCount: pinnedNotes.length,
                                  itemBuilder: (context, index) {
                                    return NoteWidget(note: pinnedNotes[index]);
                                  },
                                ),
                              ),
                        notes.isEmpty
                            ? Container()
                            : Text("Upcoming",
                                style: TextStyle(
                                    color: HexColor.fromHex("#bdbfc3"),
                                    fontSize: 15)),
                        notes.isEmpty
                            ? Container()
                            : Expanded(
                                child: MasonryGridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 15,
                                    shrinkWrap: true,
                                    itemCount: notes.length,
                                    itemBuilder: (context, index) {
                                      return NoteWidget(note: notes[index]);
                                    }),
                              )
                      ],
                    ),
                  ));
  }
}
