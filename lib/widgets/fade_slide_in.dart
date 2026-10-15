import 'package:flutter/material.dart';

// ANIMATION (implicit): fades a child in while sliding it up.
// TweenAnimationBuilder animates a value from 0 to 1 by itself, so we
// don't need an AnimationController. Cards get a bigger [index] ->
// they start later, giving a staggered "cascade" effect.
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final int index;

  const FadeSlideIn({super.key, required this.child, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + index * 120),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
