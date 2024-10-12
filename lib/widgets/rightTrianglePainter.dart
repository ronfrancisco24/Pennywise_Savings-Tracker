import 'package:flutter/material.dart';

void drawRightTriangle(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xff274293), Colors.white], // Define the gradient colors
        begin: Alignment.topLeft, // Starting point of the gradient
        end: Alignment.bottomRight, // Ending point of the gradient
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 300); // Start at top-left
    path.lineTo(size.width * 1.5, size.height * 0.8); // Mid-right
    path.lineTo(size.width, size.height * 0.8); // Extend to the right edge
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close(); // Connect back to top-left

    canvas.drawPath(path, paint);
}

