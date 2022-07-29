import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/hex_color.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget(
      {Key? key,
      required this.title,
      required this.content,
      required this.date})
      : super(key: key);
  final String title;
  final String content;
  final String date;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  List<Color> colors = [
    HexColor.fromHex("#7ecbff"),
    HexColor.fromHex("#ffa447"),
    HexColor.fromHex("#ffa6c4"),
    HexColor.fromHex("#1eccc3"),
    HexColor.fromHex("#ffa3a3")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colors[Random().nextInt(colors.length)],
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title == ""
                  ? Container(height: 0)
                  : Text(widget.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
              widget.title == ""
                  ? Container(height: 0)
                  : const SizedBox(height: 5),
              widget.content == ""
                  ? Container(height: 0)
                  : Text(widget.content, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 15),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.date),
                  ))
            ],
          ),
        ));
  }
}
