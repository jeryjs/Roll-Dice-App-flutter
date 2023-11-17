// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import 'dice_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _dice = 1;

  void _animateDice() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _dice = Random().nextInt(6) + 1;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _animateDice();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0), // adjust the value as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/dice/$_dice.png',
                      width: 100, height: 100),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 250,
                      height: 100,
                      child: Text('DICE',
                          style: TextStyle(fontSize: 50, color: Colors.white)),
                    ),
                  ),
                  const Text(
                    'A minimalistic dice roll app',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Padding(padding: const EdgeInsets.all(30.0)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(350, 50)),
                  ),
                  onPressed: () => Navigator.push(ctx,
                      MaterialPageRoute(builder: (ctx) => const DiceScreen())),
                  child: const Text('GET STARTED'),
                ),
                Padding(padding: const EdgeInsets.all(40.0)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
