import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final double progress;
  final Color color;

  CirclePainter({
    required this.radius,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 2.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    const startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * progress;
    canvas.drawArc(
      Rect.fromCenter(center: center, width: radius * 2, height: radius * 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class CustomRadioButtons extends StatefulWidget {
  final List<String> options;
  final bool isVertical;
  final void Function(String)? onChanged;

  const CustomRadioButtons({
    super.key,
    required this.options,
    this.isVertical = true,
    this.onChanged,
  });

  @override
  _CustomRadioButtonsState createState() => _CustomRadioButtonsState();
}

class _CustomRadioButtonsState extends State<CustomRadioButtons>
    with SingleTickerProviderStateMixin {
  String? _selectedOption;
  late AnimationController _controller;
  final Color _fillColor = const Color(0xFF424242);
  final Color _borderColor = txtBlack;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isVertical
        ? Column(
            children: _buildRadioButtons(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildRadioButtons(),
          );
  }

  List<Widget> _buildRadioButtons() {
    return widget.options.map((option) {
      bool isSelected = option == _selectedOption;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedOption = option;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(option);
          }
          _controller.reset();
          _controller.forward();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.transparent : _borderColor,
                    width: 2.0,
                  ),
                  color: isSelected ? _fillColor : Colors.transparent,
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(option),
            const SizedBox(width: 15),
          ],
        ),
      );
    }).toList();
  }
}
