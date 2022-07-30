import 'package:flutter/material.dart';

import '../utils/hex_color.dart';

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
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.square_rounded,
                          color: HexColor.fromHex("#ffa447"), size: 50)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.square_rounded,
                          color: HexColor.fromHex("#7ecbff"), size: 50)),
                  const SizedBox(height: 100.0),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.square_rounded,
                          color: HexColor.fromHex("#ffa6c4"), size: 50)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.square_rounded,
                          color: HexColor.fromHex("#1eccc3"), size: 50)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.square_rounded,
                          color: HexColor.fromHex("#ffa3a3"), size: 50)),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add_rounded,
              color: HexColor.fromHex("#f7a243"), size: 40),
          onPressed: () {},
        ),
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
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: Icon(pinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: Colors.black),
              onPressed: () {
                setState(() {
                  pinned = !pinned;
                });
              },
            ),
            IconButton(
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
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
              visualDensity:
                  const VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: const Icon(Icons.access_time, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                          color: HexColor.fromHex("#343a50"),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                  style: TextStyle(
                      color: HexColor.fromHex("#343a50"),
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const TextField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Content",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 20, color: Colors.black))
            ],
          ),
        ));
  }
}
