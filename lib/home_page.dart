import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final TextStyle _myNewFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.black,
      letterSpacing: 3,
    ),
  );
  static final TextStyle _myNewFont1 = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.black,
      letterSpacing: 3,
      fontSize: 16,
    ),
  );
  static final TextStyle _myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
  ));
  bool onTurn = true;
  List<String> displayXo = <String>['', '', '', '', '', '', '', '', ''];
  int pointsX = 0;
  int pointsO = 0;
  int filledBoxes = 0;

  void _tapped(int index) {
    setState(
      () {
        if (onTurn && displayXo[index] == '') {
          setState(
            () {
              displayXo[index] = 'o';
              filledBoxes += 1;
            },
          );
        } else if (!onTurn && displayXo[index] == '') {
          setState(
            () {
              displayXo[index] = 'x';
              filledBoxes += 1;
            },
          );
        }
        onTurn = !onTurn;
        _checkWinner();
      },
    );
  }

  bool _checkWinner() {
    bool _check = false;
    if (displayXo[0] == displayXo[1] &&
        displayXo[0] == displayXo[2] &&
        displayXo[0] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[0]);
    }
    if (displayXo[3] == displayXo[4] &&
        displayXo[3] == displayXo[5] &&
        displayXo[3] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[3]);
    }
    if (displayXo[6] == displayXo[7] &&
        displayXo[6] == displayXo[8] &&
        displayXo[6] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[6]);
    }
    if (displayXo[0] == displayXo[3] &&
        displayXo[0] == displayXo[6] &&
        displayXo[0] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[0]);
    }
    if (displayXo[1] == displayXo[4] &&
        displayXo[1] == displayXo[7] &&
        displayXo[1] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[1]);
    }
    if (displayXo[2] == displayXo[5] &&
        displayXo[2] == displayXo[8] &&
        displayXo[2] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[2]);
    }
    if (displayXo[0] == displayXo[4] &&
        displayXo[0] == displayXo[8] &&
        displayXo[0] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[0]);
    }
    if (displayXo[2] == displayXo[4] &&
        displayXo[2] == displayXo[6] &&
        displayXo[2] != '') {
      setState(() => _check = true);
      _showWinDialog(displayXo[2]);
    } else if (filledBoxes == 9 && !_check) {
      _soundTie();
      _showDrawDialog();
    }
    return false;
  }

  void _showWinDialog(String winner) {
    showDialog<AlertDialog>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Winner is: ' + winner,
            style: _myNewFont1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Play Again',
                style: _myNewFont,
              ),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    if (winner == 'o') {
      setState(
        () {
          _soundWinner();
          pointsO += 1;
        },
      );
    } else if (winner == 'x') {
      setState(
        () {
          _soundWinner();
          pointsX += 1;
        },
      );
    }
  }

  void _clearBoard() {
    setState(
      () {
        for (int i = 0; i < 9; i++) {
          displayXo[i] = '';
        }
        filledBoxes = 0;
      },
    );
  }

  void _showDrawDialog() {
    showDialog<AlertDialog>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'It\'s a tie',
            style: _myNewFont1,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Play Again',
                style: _myNewFont,
              ),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _soundWinner() {
    final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio('assets/audio/808.wav'));
  }

  void _soundTie() {
    final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio('assets/audio/openhat.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player X',
                            style: _myNewFontWhite,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            pointsX.toString(),
                            style: _myNewFontWhite,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player O',
                            style: _myNewFontWhite,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            pointsO.toString(),
                            style: _myNewFontWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700])),
                        child: Center(
                          child: Text(
                            displayXo[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Tic Tac Toe',
                        style: _myNewFontWhite,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        '@Rocket Team',
                        style: _myNewFontWhite,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (pointsO != 0 || pointsX != 0) {
                    setState(
                      () {
                        pointsX = 0;
                        pointsO = 0;
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 32, top: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Reset Score',
                          style: _myNewFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _clearBoard(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 32,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Reset Game',
                          style: _myNewFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push<IntroScreen>(
                    context,
                    MaterialPageRoute<IntroScreen>(
                        builder: (BuildContext context) => IntroScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 32,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'IntroScreen',
                          style: _myNewFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
