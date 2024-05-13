import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticItemWidget extends StatefulWidget {
  final String name;
  final int value;
  final Color textColor;
  final BoxDecoration decoration;
  final Animation<double> animation;
  const StatisticItemWidget({
    super.key,
    required this.name,
    required this.value,
    required this.textColor,
    required this.animation,
    required this.decoration,
  });

  @override
  State<StatisticItemWidget> createState() => _StatisticItemWidgetState();
}

class _StatisticItemWidgetState extends State<StatisticItemWidget>
    with TickerProviderStateMixin {
  late AnimationController _counterAnimationController;

  @override
  void initState() {
    _counterAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _counterAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _counterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.animation,
      child: Container(
        width: 164.w,
        height: 164.w,
        decoration: widget.decoration,
        padding: REdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              widget.name.toUpperCase(),
              style: TextStyle(
                fontSize: 12.sp,
                color: widget.textColor,
                letterSpacing: .9,
                fontWeight: FontWeight.w400,
              ),
            ),
            30.verticalSpace,
            AnimatedBuilder(
                animation: widget.animation,
                builder: (_, __) {
                  String value =
                      (widget.animation.value * widget.value)
                          .toInt()
                          .toString();
                  if (value.length >= 4) {
                    value = '${value.substring(0, 1)} ${value.substring(1)}';
                  }
                  return Text(
                    value,
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: widget.textColor,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }),
            10.verticalSpace,
            Text(
              'offers',
              style: TextStyle(
                fontSize: 12.sp,
                color: widget.textColor,
                letterSpacing: .9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
