import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LockIcon extends StatefulWidget {
  const LockIcon({super.key, required this.lockStatus});

  final bool lockStatus;

  @override
  State<LockIcon> createState() => _LockIconState();
}

class _LockIconState extends State<LockIcon> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: widget.lockStatus
          ? Colors.greenAccent.withOpacity(0.15)
          : Colors.orangeAccent.withOpacity(0.15),
      radius: 25,
      child: SvgPicture.asset(
        'assets/images/form/lock.svg',
        height: 25,
        color: widget.lockStatus
            ? Colors.green.withOpacity(0.7)
            : Colors.amber.withOpacity(0.7),
      ),
    );
  }
}
