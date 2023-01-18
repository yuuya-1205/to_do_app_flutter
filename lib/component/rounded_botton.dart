import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.color,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Color color;
  final GestureTapCallback? onTap;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Text(widget.text),
        color: widget.color,
      ),
    );
  }
}
