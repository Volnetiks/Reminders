import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: colors[widget.note.colorID],
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
