import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pos_getx/app/style/app_colors.dart';

class Loading extends StatelessWidget {
  final double size;

  const Loading({
    super.key,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColors.primary,
        size: size,
      ),
    );
  }
}
