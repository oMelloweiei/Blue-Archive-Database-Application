import 'package:flutter/material.dart';

class myParallelogram extends CustomClipper<Path> {
  final double cornerRadius; // Radius for rounded corners

  myParallelogram({this.cornerRadius = 15.0});

  @override
  Path getClip(Size size) {
    var path = Path();

    // Define the rounded parallelogram path
    path.moveTo(size.width * 0.1 + cornerRadius, 0); // Move to top-left corner
    path.lineTo(size.width - cornerRadius, 0); // Line to top-right corner
    path.quadraticBezierTo(
        size.width, 0, size.width, cornerRadius); // Top-right corner curve
    path.lineTo(size.width * 0.9,
        size.height - cornerRadius); // Line to bottom-right corner
    path.quadraticBezierTo(
        size.width * 0.9,
        size.height,
        size.width * 0.9 - cornerRadius,
        size.height); // Bottom-right corner curve
    path.lineTo(cornerRadius, size.height); // Line to bottom-left corner
    path.quadraticBezierTo(0, size.height, 0,
        size.height - cornerRadius); // Bottom-left corner curve
    path.lineTo(size.width * 0.1, cornerRadius); // Line to top-left corner
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.1 + cornerRadius,
        0); // Top-left corner curve
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ParallelogramBorderPainter extends CustomPainter {
  final double borderWidth;
  final Color borderColor;

  ParallelogramBorderPainter({
    this.borderWidth = 10.0,
    this.borderColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Path path = myParallelogram().getClip(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
