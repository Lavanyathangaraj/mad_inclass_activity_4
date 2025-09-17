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
      title: 'Emoji Drawer',
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
  Color selectedColor = Colors.yellow; // 👈 Default emoji color
  final List<String> emojiOptions = ['party', 'heart', 'smile', 'cool'];

  final List<Color> colorOptions = [
    Colors.yellow,
    Colors.red,
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.orange, Colors.red, Colors.deepPurple],
              ).createShader(bounds),
              child: const Text(
                'Emoji Drawer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 320,
              height: 320,
              child: CustomPaint(
                painter: SmileyPainter(selectedEmoji, selectedColor),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown for emoji selection
            DropdownButton<String>(
              value: selectedEmoji,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              items: emojiOptions.map((emoji) {
                return DropdownMenuItem(
                  value: emoji,
                  child: Text(
                    emoji.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedEmoji = value!;
                });
              },
            ),
            const SizedBox(height: 15),

            // Row of color pickers
            Wrap(
              spacing: 10,
              children: colorOptions.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 18,
                    child: selectedColor == color
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  final String emojiType;
  final Color emojiColor;
  SmileyPainter(this.emojiType, this.emojiColor);

  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    switch (emojiType) {
      case 'party':
        drawPartyFace(canvas, size, Offset(size.width / 2, size.height / 2));
        break;
      case 'heart':
        drawHeart(canvas, size, Offset(size.width / 2, size.height / 2));
        break;
      case 'smile':
        drawSmileyFace(canvas, size, Offset(size.width / 2, size.height / 2));
        break;
      case 'cool':
        drawCoolFace(canvas, size, Offset(size.width / 2, size.height / 2));
        break;
      default:
        drawSmileyFace(canvas, size, Offset(size.width / 2, size.height / 2));
    }
  }

  void drawSmileyFace(Canvas canvas, Size size, Offset center) {
    final facePaint = Paint()..color = emojiColor; // 👈 Use custom color
    canvas.drawCircle(center, size.width / 3, facePaint);

    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 12, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 12, eyePaint);

    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final mouthPath = Path();
    mouthPath.moveTo(center.dx - 50, center.dy + 20);
    mouthPath.quadraticBezierTo(center.dx, center.dy + 60, center.dx + 50, center.dy + 20);
    canvas.drawPath(mouthPath, mouthPaint);
  }

  void drawPartyFace(Canvas canvas, Size size, Offset center) {
    final faceRadius = size.width / 2.5;
    final facePaint = Paint()
      ..shader = RadialGradient(
        colors: [emojiColor, emojiColor.withOpacity(0.7)], // 👈 Use selected color
        center: Alignment(-0.2, -0.2),
        radius: 0.9,
      ).createShader(Rect.fromCircle(center: center, radius: faceRadius));
    canvas.drawCircle(center, faceRadius, facePaint);

    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(center.dx - 40, center.dy - 30), 14, eyePaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy - 30), 14, eyePaint);

    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final path = Path();
    path.moveTo(center.dx - 50, center.dy + 40);
    path.quadraticBezierTo(center.dx, center.dy + 70, center.dx + 50, center.dy + 40);
    canvas.drawPath(path, mouthPaint);

    final hatPaint = Paint()..color = Colors.redAccent;
    final hatPath = Path();
    hatPath.moveTo(center.dx, center.dy - 120);
    hatPath.lineTo(center.dx - 60, center.dy - 40);
    hatPath.lineTo(center.dx + 60, center.dy - 40);
    hatPath.close();
    canvas.drawPath(hatPath, hatPaint);

    final stripePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;
    canvas.drawLine(Offset(center.dx, center.dy - 120), Offset(center.dx, center.dy - 40), stripePaint);

    final pomPomPaint = Paint()..color = Colors.orange;
    canvas.drawCircle(Offset(center.dx, center.dy - 120), 10, pomPomPaint);

    final confettiColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.cyan,
      Colors.pinkAccent
    ];
    for (int i = 0; i < 35; i++) {
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
          final tri = Path();
          tri.moveTo(x, y - 5);
          tri.lineTo(x - 5, y + 5);
          tri.lineTo(x + 5, y + 5);
          tri.close();
          canvas.drawPath(tri, confettiPaint);
          break;
      }
    }
  }

  void drawHeart(Canvas canvas, Size size, Offset center) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [emojiColor, emojiColor.withOpacity(0.6)], // 👈 Custom heart color
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: 100));

    Path path = Path();
    path.moveTo(center.dx, center.dy + 60);
    path.cubicTo(
      center.dx - 100, center.dy - 20,
      center.dx - 40, center.dy - 120,
      center.dx, center.dy - 40,
    );
    path.cubicTo(
      center.dx + 40, center.dy - 120,
      center.dx + 100, center.dy - 20,
      center.dx, center.dy + 60,
    );
    canvas.drawPath(path, paint);
  }

  void drawCoolFace(Canvas canvas, Size size, Offset center) {
    final facePaint = Paint()..color = emojiColor; // 👈 Custom face color
    canvas.drawCircle(center, size.width / 3, facePaint);

    final glassesPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawLine(Offset(center.dx - 50, center.dy - 20), Offset(center.dx + 50, center.dy - 20), glassesPaint);
    canvas.drawRect(Rect.fromCenter(center: Offset(center.dx - 35, center.dy - 20), width: 40, height: 25), glassesPaint);
    canvas.drawRect(Rect.fromCenter(center: Offset(center.dx + 35, center.dy - 20), width: 40, height: 25), glassesPaint);

    final mouthPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final mouthPath = Path();
    mouthPath.moveTo(center.dx - 40, center.dy + 40);
    mouthPath.quadraticBezierTo(
      center.dx, center.dy + 70,
      center.dx + 40, center.dy + 40,
    );
    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
