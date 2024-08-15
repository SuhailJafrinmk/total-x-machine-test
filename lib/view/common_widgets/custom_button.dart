import 'package:flutter/material.dart';

class CustomButtonBlack extends StatefulWidget {
  final double? width;
  final Color? color;
  final String text;
  final double? height;
  final VoidCallback? ontap;
  final double? buttonRadius;
  final Color? textColor;
  final double? elevation;

  CustomButtonBlack({
    super.key,
    required this.text,
    this.buttonRadius,
    this.width,
    this.color,
    this.height,
    this.ontap,
    this.textColor,
    this.elevation,
  });

  @override
  State<CustomButtonBlack> createState() => _CustomButtonBlackState();
}

class _CustomButtonBlackState extends State<CustomButtonBlack> {
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    buttonColor = widget.color ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Material(
        elevation: widget.elevation ?? 10,
        color: widget.color ?? Colors.black,
        borderRadius: BorderRadius.circular(widget.buttonRadius ?? 30),
        child: Container(
          width: widget.width ?? size.width * 0.9,
          height: widget.height ?? size.height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.buttonRadius ?? 30),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
