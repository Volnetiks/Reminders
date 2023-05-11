import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/utils/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/notifications_api.dart';
import '../database/notes_database.dart';
import '../models/note_list_model.dart';
import '../models/note_model.dart';

class ValidatedTasksPage extends StatefulWidget {
  const ValidatedTasksPage({super.key});

  @override
  State<ValidatedTasksPage> createState() => _ValidatedTasksPageState();
}

class _ValidatedTasksPageState extends State<ValidatedTasksPage> {
  late List<Note> notes;

  bool isLoading = true;
  bool masonryView = true;

  late TextEditingController _searchBarController;

  @override
  void initState() {
    super.initState();

    _searchBarController = TextEditingController();

    loadPreferences();

    NotificationsApi.init();

    refreshNotes();
  }

  Future loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    bool? view = prefs.getBool("masonryView");
    masonryView = view ?? true;
    setState(() {});
  }

  Future updatePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("masonryView", masonryView);
  }

  Future refreshNotes() async {
    notes = await NotesDatabase.instance.readFinishedNotes("");

    setState(() {
      isLoading = false;
    });
  }

  Future searchNotes(String value) async {
    notes = await NotesDatabase.instance.readFinishedNotes(value);

    setState(() {});
  }

  Future updateNotes(int index, List<Note> notes) async {
    Note note = notes[index];
    await NotesDatabase.instance.update(note.copy(isDone: false));
    setState(() {
      notes.removeAt(index);
    });
    FToast fToast = FToast();
    // ignore: use_build_context_synchronously
    fToast.init(context);
    fToast.showToast(
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.greenAccent,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check),
                SizedBox(
                  width: 12.0,
                ),
                Text("Task is now available again."),
                SizedBox(width: 12),
              ],
            )),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2));
    searchNotes(_searchBarController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () {
                          masonryView = !masonryView;
                          updatePreferences();
                          setState(() {});
                        },
                        icon: const Icon(Icons.list, size: 35)),
                    const SizedBox(height: 60.0),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded, size: 35)),
                  ],
                ),
              )),
        ),
        extendBody: true,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        height: 40.0,
                        width: 250.0,
                        alignment: const Alignment(-1.0, 0.0),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 18),
                            SizedBox(
                              height: 23.0,
                              width: 180.0,
                              child: TextField(
                                controller: _searchBarController,
                                cursorRadius: const Radius.circular(10.0),
                                cursorWidth: 2.0,
                                cursorColor: Colors.black,
                                onChanged: ((value) {
                                  searchNotes(value);
                                }),
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
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            _searchBarController.text == ""
                                ? Container(
                                    color: Colors.white, width: 20, height: 20)
                                : SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        iconSize: 20,
                                        onPressed: () {
                                          setState(() {
                                            _searchBarController.clear();
                                          });
                                          searchNotes("");
                                        },
                                        icon: const Icon(
                                          Icons.close_rounded,
                                        )),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Text("Reminders",
                        style: TextStyle(
                            color: HexColor.fromHex("#343a50"),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    notes.isEmpty
                        ? Container()
                        : Text("Completed Tasks",
                            style: TextStyle(
                                color: HexColor.fromHex("#bdbfc3"),
                                fontSize: 15)),
                    notes.isEmpty
                        ? Container()
                        : Expanded(
                            child: masonryView
                                ? MasonryGridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 15,
                                    itemCount: notes.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                          key: ValueKey<int>(notes[index].id!),
                                          background: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.lightGreen,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              child: const Icon(
                                                  Icons.close_rounded)),
                                          direction: index.isEven
                                              ? DismissDirection.endToStart
                                              : DismissDirection.startToEnd,
                                          onDismissed: (direction) {
                                            updateNotes(index, notes);
                                          },
                                          child:
                                              NoteWidget(note: notes[index]));
                                    },
                                  )
                                : ListView.separated(
                                    separatorBuilder: ((context, index) {
                                      return const SizedBox(height: 10);
                                    }),
                                    itemCount: notes.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                          key: ValueKey<int>(notes[index].id!),
                                          background: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.lightGreen,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              child: const Icon(
                                                  Icons.close_rounded)),
                                          direction:
                                              DismissDirection.horizontal,
                                          onDismissed: (direction) {
                                            updateNotes(index, notes);
                                          },
                                          child: NoteWidgetList(
                                              note: notes[index]));
                                    }),
                          )
                  ],
                ),
              ));
  }
}
