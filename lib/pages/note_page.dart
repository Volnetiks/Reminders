import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool pinned = false;
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
          icon: Icon(pinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: Colors.black),
          onPressed: () {
            setState(() {
              pinned = !pinned;
            });
          },
        ),
        IconButton(
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
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
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
          icon: const Icon(Icons.access_time, color: Colors.black),
          onPressed: () {},
        )
      ],
    ));
  }
}
