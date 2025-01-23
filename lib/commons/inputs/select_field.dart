import 'package:flutter/material.dart';

class PropertyButton extends StatefulWidget {
  final double width;
  final double height;
  final EdgeInsets padding;
  final double borderRadius;
  final String text;
  final String fontFamily;
  final bool isSelected;

  PropertyButton({
    this.width = 358,
    this.height = 50,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 8,
    this.text = 'Une fois par semaine',
    this.fontFamily = 'DM Sans',
    this.isSelected = false,
  });

  @override
  _PropertyButtonState createState() => _PropertyButtonState();
}

class _PropertyButtonState extends State<PropertyButton> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Column(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: isSelected ? Color(0xFFDDD4FF) : Color(0xFFF5F8FC),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isSelected ? 1 : 0,
                  color: isSelected ? Color(0xFF8352FF) : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontFamily: widget.fontFamily,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
