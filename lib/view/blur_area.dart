import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoooze/view/blur_notifier.dart';

class BlurArea extends StatelessWidget {
  const BlurArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BlurNotifier>(builder: (context, blurNotifier, child) {
      final needBlur = blurNotifier.value;
      if (needBlur) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
                color: Colors.black.withOpacity(0),
                child: GestureDetector(
                    onTap: context.read<BlurNotifier>().unBlurScreen)));
      }
      return const SizedBox();
    });
  }
}
