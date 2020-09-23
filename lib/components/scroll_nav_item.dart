import 'package:flutter/material.dart';

import '../constants.dart';

class ScrollNavItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  ScrollNavItem(
      {@required this.title,
      @required this.icon,
      this.isSelected = false,
      this.onTap});

  @override
  _ScrollNavItemState createState() => _ScrollNavItemState();
}

class _ScrollNavItemState extends State<ScrollNavItem> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Icon(
          widget.icon,
          size: 30,
          color: widget.isSelected ? kButtonsColor : Colors.white30,
        ),
      ),
    );
  }
}
