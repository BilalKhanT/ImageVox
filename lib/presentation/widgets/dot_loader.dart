import 'package:flutter/material.dart';

class DotLoader extends StatefulWidget {
  const DotLoader({super.key, this.loaderColor});
  final Color? loaderColor;
  @override
  // ignore: library_private_types_in_public_api
  _DotLoaderState createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation1;
  Animation<double>? _animation2;
  Animation<double>? _animation3;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 0.6, curve: Curves.ease),
      ),
    );
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.2, 0.8, curve: Curves.ease),
      ),
    );
    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.4, 1.0, curve: Curves.ease),
      ),
    );
    _controller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Dot(
          animation: _animation1,
          color: widget.loaderColor,
        ),
        const SizedBox(width: 8),
        Dot(
          animation: _animation2,
          color: widget.loaderColor,
        ),
        const SizedBox(width: 8),
        Dot(
          animation: _animation3,
          color: widget.loaderColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final Animation<double>? animation;
  final Color? color;
  const Dot({
    super.key,
    this.animation,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation!,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
