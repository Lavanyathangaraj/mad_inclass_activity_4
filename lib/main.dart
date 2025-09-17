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
      title: 'Enhanced Party Emoji',
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
  String selectedEmoji = 'party';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.pinkAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 280,
              height: 280,
              child: CustomPaint(
                painter: EmojiPainter(selectedEmoji),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emojiButton('party', '🥳 Party'),
                const SizedBox(width: 20),
                emojiButton('heart', '❤️ Heart'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emojiButton(String name, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selectedEmoji == name ? Colors.white : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
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
        drawEnhancedPartyFace(canvas, size);
        break;
      case 'heart':
        drawHeart(canvas, size);
        break;
      default:
        drawEnhancedPartyFace(canvas, size);
    }
  }

  void drawEnhancedPartyFace(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRadius = size.width / 2;

    final facePaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.yellow, Colors.orangeAccent.shade700],
        center: Alignment(-0.2, -0.2),
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: center, radius: faceRadius));
    canvas.drawCircle(center, faceRadius, facePaint);

    final eyePaint = Paint()..color = Colors.black;
    final eyeGlowPaint = Paint()..color = Colors.white.withOpacity(0.5);
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.35), 16, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 16, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.34, size.height * 0.34), 6, eyeGlowPaint);
    canvas.drawCircle(Offset(size.width * 0.64, size.height * 0.34), 6, eyeGlowPaint);

    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final path = Path();
    path.moveTo(size.width * 0.25, size.height * 0.65);
    path.quadraticBezierTo(size.width / 2, size.height * 0.9, size.width * 0.75, size.height * 0.65);
    canvas.drawPath(path, mouthPaint);

    final hatPaint = Paint()..color = Colors.redAccent;
    final hatPath = Path();
    hatPath.moveTo(center.dx, size.height * -0.05);
    hatPath.lineTo(size.width * 0.25, size.height * 0.2);
    hatPath.lineTo(size.width * 0.75, size.height * 0.2);
    hatPath.close();
    canvas.drawPath(hatPath, hatPaint);

    final stripePaint = Paint()..color = Colors.yellowAccent..strokeWidth = 4;
    canvas.drawLine(Offset(center.dx, size.height * -0.05), Offset(center.dx, size.height * 0.2), stripePaint);

    final pomPomPaint = Paint()..color = Colors.orange;
    canvas.drawCircle(Offset(center.dx, size.height * -0.05), 10, pomPomPaint);

    final confettiColors = [Colors.red, Colors.green, Colors.blue, Colors.purple, Colors.orange, Colors.cyan, Colors.pinkAccent];
    for (int i = 0; i < 40; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height * 0.5;
      final shapeType = random.nextInt(3);
      final confettiPaint = Paint()..color = confettiColors[random.nextInt(confettiColors.length)];
      switch (shapeType) {
        case 0:
          canvas.drawCircle(Offset(x, y), 5, confettiPaint);
          break;
        case 1:
          canvas.drawRect(Rect.fromCenter(center: Offset(x, y), width: 6, height: 6), confettiPaint);
          break;
        case 2:
          final path = Path();
          path.moveTo(x, y - 5);
          path.lineTo(x - 5, y + 5);
          path.lineTo(x + 5, y + 5);
          path.close();
          canvas.drawPath(path, confettiPaint);
          break;
      }
    }

    for (int i = 0; i < 12; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white.withOpacity(0.8));
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
