import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatefulWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  State<SampleItemDetailsView> createState() => _SampleItemDetailsViewState();
}

class _SampleItemDetailsViewState extends State<SampleItemDetailsView> {
  late ConfettiController _controllerCenter;
  // late final AudioPlayer _audioPlayer;

  final player = AudioPlayer();
  @override
  void initState() {
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 30),
    );

    playSound();
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Stack(children: [
        Center(
          child: Image.asset('assets/images/hbd.png'),
        ),
        Column(
          children: [
            confeTeei(),
          ],
        ),
      ]),
    );
  }

  ConfettiWidget confeTeei() {
    return ConfettiWidget(
      confettiController: _controllerCenter,
      emissionFrequency: 0.09,
      blastDirectionality: BlastDirectionality.explosive,
      blastDirection: -pi / 2,
      // shouldLoop: true,
      minBlastForce: 10,
      maxBlastForce: 100,
      colors: const [
        Colors.amberAccent,
        Colors.limeAccent,
        Colors.orange,
        Colors.red,
        Colors.blue,
        Colors.yellow,
        Colors.pink,
        Colors.purple,
        Colors.brown,
        Colors.green,
      ],
      strokeWidth: 0.3,
      particleDrag: 0.05,
      maximumSize: const Size(20, 20),
      minimumSize: const Size(2, 2),
      gravity: 0.01,
      // createParticlePath: drawStar,
    );
  }

  Future<void> playSound() async {
    String audioPath = 'audio/hbd.mp3';
    await player.play(AssetSource(audioPath));
  }
}
