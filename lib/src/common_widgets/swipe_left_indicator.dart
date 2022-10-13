import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SwipeLeftIndicator extends StatelessWidget {
  const SwipeLeftIndicator({Key? key}) : super(key: key);

  Color get color => Colors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.arrow_back_rounded,
          color: color,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          'Swipe left',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color,
              ),
        ),
      ],
    )
        .animate(onPlay: (controller) => controller.repeat())
        .slide(
          duration: 1.seconds,
          curve: Curves.easeIn,
          begin: Offset.zero,
          end: const Offset(-0.1, 0),
        )
        .then()
        .slide(
          curve: Curves.easeOut,
          duration: 0.7.seconds,
          begin: const Offset(-0.1, 0),
          end: Offset.zero,
        )
        .then(delay: 0.5.seconds);
  }
}
