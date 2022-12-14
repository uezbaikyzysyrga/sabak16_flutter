import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Piano'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        PianoWhitButton(nameNote: 1),
                        PianoWhitButton(nameNote: 2),
                        PianoWhitButton(nameNote: 3),
                        PianoWhitButton(nameNote: 4),
                        PianoWhitButton(nameNote: 5),
                        PianoWhitButton(nameNote: 6),
                        PianoWhitButton(nameNote: 7)
                      ],
                    ),
                    Positioned(
                      left: 43,
                      right: 0.0,
                      top: 0.0,
                      child: Row(
                        children: const [
                          PianoBlackButton(nameNote: 1),
                          PianoBlackButton(nameNote: 2),
                          PianoBlackButton(visible: false, nameNote: 3),
                          PianoBlackButton(nameNote: 4),
                          PianoBlackButton(nameNote: 5),
                          PianoBlackButton(nameNote: 6),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PianoBlackButton extends StatelessWidget {
  const PianoBlackButton({
    this.visible = true,
    required this.nameNote,
    Key? key,
  }) : super(key: key);

  final bool visible;
  final int nameNote;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.5),
      child: SizedBox(
        width: 65,
        height: 150,
        child: Visibility(
          visible: visible,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.black,
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  return states.contains(MaterialState.pressed)
                      ? const Color.fromARGB(255, 71, 70, 70)
                      : null;
                },
              ),
            ),
            onPressed: () {
              AudioPlayer().play(
                AssetSource('notes/note$nameNote.wav'),
              );
            },
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text('f3'),
            ),
          ),
        ),
      ),
    );
  }
}

class PianoWhitButton extends StatelessWidget {
  const PianoWhitButton({
    Key? key,
    required this.nameNote,
  }) : super(key: key);
  final int nameNote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 80,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.white),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.pressed)
                  ? const Color.fromARGB(255, 186, 184, 184)
                  : null;
            }),
          ),
          onPressed: () {
            AudioPlayer().play(
              AssetSource('notes/note$nameNote.wav'),
            );
          },
          child: const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'f3',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
