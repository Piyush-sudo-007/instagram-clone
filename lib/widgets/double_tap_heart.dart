import 'package:flutter/material.dart';

class DoubleTapHeart extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDoubleTap;

  const DoubleTapHeart({super.key, required this.child, this.onDoubleTap});

  @override
  State<DoubleTapHeart> createState() => _DoubleTapHeartState();
}

class _DoubleTapHeartState extends State<DoubleTapHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  bool showHeart = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showHeart = false;
        });
      }
    });
  }

  void handleDoubleTap() {
    setState(() {
      showHeart = true;
    });

    controller.forward(from: 0);

    widget.onDoubleTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: handleDoubleTap,

      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,

          if (showHeart)
            ScaleTransition(
              scale: Tween(begin: 0.8, end: 1.4).animate(controller),
              child: const Icon(Icons.favorite, color: Colors.white, size: 100),
            ),
        ],
      ),
    );
  }
}
