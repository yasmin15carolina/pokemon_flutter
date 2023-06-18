import 'package:flutter/material.dart';

class PlayerIdle extends StatefulWidget {
  @override
  _PlayerIdleState createState() => _PlayerIdleState();
}

class _PlayerIdleState extends State<PlayerIdle> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<int> runningAnimation;
  List<String> paths = [
    "assets/NinjaGirl/Idle__000.png",
    "assets/NinjaGirl/Idle__001.png",
    "assets/NinjaGirl/Idle__002.png",
    "assets/NinjaGirl/Idle__003.png",
    "assets/NinjaGirl/Idle__004.png",
    "assets/NinjaGirl/Idle__005.png",
    "assets/NinjaGirl/Idle__006.png",
    "assets/NinjaGirl/Idle__007.png",
    "assets/NinjaGirl/Idle__008.png",
    "assets/NinjaGirl/Idle__009.png",
  ];
  double start = 0, end = 8;
  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    runningAnimation = IntTween(begin: 0, end: 8).animate(controller);
    runningAnimation.addListener(() {
      if (controller.isCompleted) {
        controller.reset();
        controller.forward();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: runningAnimation,
      builder: (context, child) {
        return Container(
            child: Container(
          child: Image.asset(
            paths[runningAnimation.value],
            scale: 4,
          ),
        ));
      },
    );
  }
}
