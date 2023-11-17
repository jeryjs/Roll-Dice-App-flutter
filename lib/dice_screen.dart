import 'dart:math';
import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with TickerProviderStateMixin {
  int _dice1State = 1;
  int _dice2State = 1;
  String _youRolled = '...';
  // ignore: prefer_typing_uninitialized_variables
  var _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  void _diceRolled() async {
    var random = Random();

    _controller.forward(from: 0.0); // start the animation

    for (var i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _youRolled = '.' * (i ~/ 3);
        _dice1State = random.nextInt(6) + 1;
        _dice2State = random.nextInt(6) + 1;
      });
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _dice1State = random.nextInt(6) + 1;
        _dice2State = random.nextInt(6) + 1;
        _youRolled = (_dice1State + _dice2State).toString();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Reset")),
              const PopupMenuItem(value: 2, child: Text("About")),
            ],
            onSelected: (value) {
              if (value == 1) {
                setState(() {_dice1State = 1; _dice2State = 1; _youRolled = '...';});
              } else if (value == 2) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('About'),
                    content: const Text('This is a minimalistic dice roll app made with Flutter.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(ctx),child: const Text('OK'))],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 200)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RotationTransition(
                    turns: _controller,
                    child: Image.asset(
                      'assets/dice/$_dice1State.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  RotationTransition(
                    turns: _controller,
                    child: Image.asset(
                      'assets/dice/$_dice2State.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 100)),
            Text("You rolled : $_youRolled",
                style: const TextStyle(fontSize: 20)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: const Size(350, 50),
                    ),
                    onPressed: () => _diceRolled(),
                    child: const Text('ROLL'),
                  ),
                  const Padding(padding: EdgeInsets.all(40.0)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
