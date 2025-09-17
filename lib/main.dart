import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: const Center(
          child: UniqueSmiley(),
        ),
      ),
    );
  }
}

class UniqueSmiley extends StatelessWidget {
  const UniqueSmiley({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Colors.yellow, Colors.orangeAccent],
          center: Alignment(-0.2, -0.2),
          radius: 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 15,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 60,
            top: 65,
            child: Stack(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 6,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 60,
            top: 65,
            child: Stack(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 6,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: SizedBox(
              width: 120,
              height: 60,
              child: CustomPaint(
                painter: ShortSmilePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortSmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.85, size.width, size.height * 0.5);
    canvas.drawPath(path, paint);

    final dimplePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(0, size.height * 0.5), 3, dimplePaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.5), 3, dimplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
