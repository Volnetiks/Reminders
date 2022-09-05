import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/pages/note_page.dart';
import 'package:reminders/utils/hex_color.dart';
import 'dart:math' as math;

import '../api/notifications_api.dart';
import '../database/notes_database.dart';
import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<Note> pinnedNotes;
  late List<Note> notes;

  bool isLoading = true;
  bool toggle = false;

  late AnimationController _animationController;
  late TextEditingController _searchBarController;

  @override
  void initState() {
    super.initState();

    _searchBarController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );

    NotificationsApi.init();

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60.0,
                              width: 250.0,
                              alignment: const Alignment(-1.0, 0.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 375),
                                height: 48.0,
                                width: (!toggle) ? 48.0 : 250.0,
                                curve: Curves.easeOut,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: -10.0,
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 10.0),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 375),
                                      top: 6.0,
                                      right: 7.0,
                                      curve: Curves.easeOut,
                                      child: AnimatedOpacity(
                                        opacity: (!toggle) ? 0.0 : 1.0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF2F3F7),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: AnimatedBuilder(
                                            builder: (context, widget) {
                                              return Transform.rotate(
                                                angle:
                                                    _animationController.value *
                                                        2.0 *
                                                        math.pi,
                                                child: widget,
                                              );
                                            },
                                            animation: _animationController,
                                            child: const Icon(
                                              Icons.mic,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedPositioned(
                                      duration:
                                          const Duration(milliseconds: 375),
                                      left: (!toggle) ? 20.0 : 40.0,
                                      curve: Curves.easeOut,
                                      top: 11.0,
                                      child: AnimatedOpacity(
                                        opacity: (!toggle) ? 0.0 : 1.0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Container(
                                          height: 23.0,
                                          width: 180.0,
                                          child: TextField(
                                            controller: _searchBarController,
                                            cursorRadius:
                                                const Radius.circular(10.0),
                                            cursorWidth: 2.0,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              labelText: 'Search...',
                                              labelStyle: const TextStyle(
                                                color: Color(0xff5B5B5B),
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              alignLabelWithHint: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: IconButton(
                                        splashRadius: 19.0,
                                        icon:
                                            const Icon(Icons.search, size: 18),
                                        onPressed: () {
                                          setState(
                                            () {
                                              if (!toggle) {
                                                toggle = true;
                                                _animationController.forward();
                                              } else {
                                                toggle = false;
                                                _searchBarController.clear();
                                                _animationController.reverse();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.person, size: 60)),
                          ],
                        ),
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
