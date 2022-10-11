import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reminders/database/notes_database.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/utils/date_utils.dart';

import '../utils/hex_color.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<Color> colors = [
    HexColor.fromHex("#ffa447"),
    HexColor.fromHex("#7ecbff"),
    HexColor.fromHex("#ffa6c4"),
    HexColor.fromHex("#1eccc3"),
    HexColor.fromHex("#ffa3a3")
  ];

  bool markedDone = false;

  Future updateNote() async {
    await NotesDatabase.instance
        .update(widget.note.copy(isDone: !widget.note.isDone));

    markedDone = !markedDone;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        updateNote();
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.greenAccent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(widget.note.isDone
                        ? "Task has been marked as unfinished"
                        : "Task has been marked as completed"),
                    const SizedBox(width: 12),
                    GestureDetector(
                        onTap: () {
                          updateNote();
                          fToast.removeCustomToast();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.red)))
                  ],
                )),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 4));
      },
      child: Container(
          decoration: BoxDecoration(
              color:
                  markedDone ? Colors.greenAccent : colors[widget.note.colorID],
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.note.title == ""
                    ? Container(height: 0)
                    : Text(widget.note.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                widget.note.title == ""
                    ? Container(height: 0)
                    : const SizedBox(height: 5),
                widget.note.content == ""
                    ? Container(height: 0)
                    : Text(widget.note.content,
                        style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 15),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(widget.note.dueDate.formatNotesDate()),
                    ))
              ],
            ),
          )),
    );
  }
}
