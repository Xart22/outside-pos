import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_getx/app/style/app_colors.dart';

class Loading extends StatelessWidget {
  final double size;
  final String? label;

  const Loading({
    super.key,
    this.size = 50,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xCC1A1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingAnimationWidget.inkDrop(
            color: AppColors.primary,
            size: size,
          ),
          if (label != null) ...[
            const SizedBox(height: 10),
            Text(
              label!,
              style: const TextStyle(color: Color(0xffF1F1F1), fontSize: 12),
            ),
          ]
        ],
      ),
    );
  }
}
