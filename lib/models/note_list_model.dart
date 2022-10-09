import 'package:flutter/material.dart';
import 'package:reminders/models/note.dart';
import 'package:reminders/utils/date_utils.dart';

import '../utils/hex_color.dart';

class NoteWidgetList extends StatefulWidget {
  const NoteWidgetList({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<NoteWidgetList> createState() => _NoteWidgetListState();
}

class _NoteWidgetListState extends State<NoteWidgetList> {
  List<Color> colors = [
    HexColor.fromHex("#ffa447"),
    HexColor.fromHex("#7ecbff"),
    HexColor.fromHex("#ffa6c4"),
    HexColor.fromHex("#1eccc3"),
    HexColor.fromHex("#ffa3a3")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colors[widget.note.colorID],
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.note.title == ""
                      ? Container(height: 0)
                      : Text(widget.note.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
              widget.note.title == ""
                  ? Container(height: 0)
                  : const SizedBox(height: 5),
              widget.note.content == ""
                  ? Container(height: 0)
                  : Text(widget.note.content,
                      style: const TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
