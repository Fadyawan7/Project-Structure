import 'package:flutter/material.dart';
import 'package:flutter_template/core/shared/themes/app_colors.dart';
import 'package:flutter_template/core/shared/themes/app_text_styles.dart';
import 'package:flutter_template/core/shared/widgets/animations/colorize_text_transitions.dart';
import 'package:flutter_template/core/shared/widgets/animations/wavy_text_transitions.dart';

class TextLoading extends StatelessWidget {
  const TextLoading({super.key, this.text = 'Loading...'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      pause: Duration.zero,
      animatedTexts: [
        WavyAnimatedText(
          text,
          textStyle: AppTextStyles.textMed24.copyWith(color: AppColors.white),
          speed: const Duration(milliseconds: 150),
        ),
      ],
      onTap: () {},
    );
  }
}
