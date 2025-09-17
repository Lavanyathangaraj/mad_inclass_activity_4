import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Party Emoji',
      home: const EmojiDrawingScreen(),
    );
  }
}

class EmojiDrawingScreen extends StatefulWidget {
  const EmojiDrawingScreen({super.key});

  @override
  State<EmojiDrawingScreen> createState() => _EmojiDrawingScreenState();
}

class _EmojiDrawingScreenState extends State<EmojiDrawingScreen> {
  String selectedEmoji = 'party'; // Default emoji

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unique Party Emoji'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: CustomPaint(
                  painter: EmojiPainter(selectedEmoji),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                emojiButton('party', '🥳 Party'),
                emojiButton('heart', '❤️ Heart'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiButton(String name, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedEmoji = name;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedEmoji == name ? Colors.deepPurple : Colors.grey,
      ),
      child: Text(label),
    );
  }
}

class EmojiPainter extends CustomPainter {
  final String emojiType;
  EmojiPainter(this.emojiType);

  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    switch (emojiType) {
      case 'party':
        drawAdvancedPartyFace(canvas, size);
        break;
      case 'heart':
        drawHeart(canvas, size);
        break;
      default:
        drawAdvancedPartyFace(canvas, size);
    }
  }

  void drawAdvancedPartyFace(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRadius = size.width / 2;

    // Gradient face
    final facePaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.yellow, Colors.orangeAccent.shade700],
        center: Alignment(-0.2, -0.2),
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: center, radius: faceRadius));
    canvas.drawCircle(center, faceRadius, facePaint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    final eyeGlowPaint = Paint()..color = Colors.white.withOpacity(0.5);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.35), 16, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 16, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.34, size.height * 0.34), 6, eyeGlowPaint);
    canvas.drawCircle(Offset(size.width * 0.64, size.height * 0.34), 6, eyeGlowPaint);

    // Big cheerful mouth
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(size.width * 0.25, size.height * 0.65);
    path.quadraticBezierTo(size.width / 2, size.height * 0.9, size.width * 0.75, size.height * 0.65);
    canvas.drawPath(path, mouthPaint);

    // Party hat (above the smiley)
    final hatPaint = Paint()..color = Colors.redAccent;
    final hatPath = Path();
    hatPath.moveTo(center.dx, size.height * -0.05); // top above face
    hatPath.lineTo(size.width * 0.25, size.height * 0.2);
    hatPath.lineTo(size.width * 0.75, size.height * 0.2);
    hatPath.close();
    canvas.drawPath(hatPath, hatPaint);

    // Hat stripe
    final stripePaint = Paint()..color = Colors.yellowAccent..strokeWidth = 4;
    canvas.drawLine(Offset(center.dx, size.height * -0.05), Offset(center.dx, size.height * 0.2), stripePaint);

    // Hat pom-pom
    final pomPomPaint = Paint()..color = Colors.orange;
    canvas.drawCircle(Offset(center.dx, size.height * -0.05), 10, pomPomPaint);

    // Dynamic confetti
    final confettiColors = [Colors.red, Colors.green, Colors.blue, Colors.purple, Colors.orange];
    for (int i = 0; i < 30; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height * 0.4;
      canvas.drawCircle(Offset(x, y), 5, Paint()..color = confettiColors[random.nextInt(confettiColors.length)]);
    }

    // Optional sparkles
    for (int i = 0; i < 10; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white.withOpacity(0.7));
    }
  }

  void drawHeart(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;

    Path path = Path();
    path.moveTo(size.width / 2, size.height * 0.7);
    path.cubicTo(
      size.width * 0.1, size.height * 0.5,
      size.width * 0.3, size.height * 0.1,
      size.width / 2, size.height * 0.3,
    );
    path.cubicTo(
      size.width * 0.7, size.height * 0.1,
      size.width * 0.9, size.height * 0.5,
      size.width / 2, size.height * 0.7,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
