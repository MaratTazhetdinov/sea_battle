part of '../ui_kit_part.dart';

class PathPainter extends CustomPainter {
  final Path path;
  final BuildContext context;
  final Color? color;
  final PaintingStyle? paintingStyle;
  final double? strokeWidth;

  const PathPainter({
    required this.path,
    required this.context,
    this.color,
    this.paintingStyle,
    this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color ?? context.theme.colors.transparent
      ..style = paintingStyle ?? PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
