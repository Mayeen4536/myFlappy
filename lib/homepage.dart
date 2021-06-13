import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myflappy/barriers.dart';
import 'package:myflappy/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double yaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = yaxis;
  bool gameHasStarted = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.8;
  int points = 0;
  double size1 = 180.0;
  double size2 = 160.0;
  double size3 = 0;
  double size4 = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = yaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.2 * time;
      setState(() {
        yaxis = initialHeight - height;
        barrierXOne -= 0.04;
        barrierXTwo -= 0.04;
      });

      setState(() {
        if (barrierXOne < -2) {
          points += 1;
          barrierXOne += 4;
        } else {
          barrierXOne -= 0.01;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          points += 1;
          barrierXTwo += 4;
        } else {
          barrierXTwo -= 0.01;
        }
      });

      if (yaxis > 1) {
        timer.cancel();
        yaxis = 1;
        gameHasStarted = false;
        
        barrierXOne = 1;
        barrierXTwo = barrierXOne + 1.8;
      }

      if (barrierXOne > -0.08 && barrierXOne < 0.08) {
        if ((yaxis > 0.36) || (yaxis < -0.76)) {
          timer.cancel();
          yaxis = 1;
          gameHasStarted = false;

          barrierXOne = 1;
          barrierXTwo = barrierXOne + 1.8;
        }
      }

       if (barrierXTwo > -0.08 && barrierXTwo < 0.08) {
        if ((yaxis > 0.7) || (yaxis < -0.5)) {
          timer.cancel();
          yaxis = 1;
          gameHasStarted = false;

          barrierXOne = 1;
          barrierXTwo = barrierXOne + 1.8;
        }
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, yaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.16),
                      child: gameHasStarted
                          ? Text(' ')
                          : Text(
                              'T A P   T O   P L A Y',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 160.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 120.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.green[900],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SCORE',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '$points',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Made with ",
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.favorite,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: " by Mayeen",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
