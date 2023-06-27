import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';

// ignore: must_be_immutable
class ErrorText extends StatelessWidget {
  final String? errorMessage;
  double size;

  ErrorText({Key? key, @required this.errorMessage, this.size = 13.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return errorMessage!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 5, left: 7),
            child: Container(
              padding: const EdgeInsets.only(bottom: 3.0, right: 3.0),
              child: buildTextRegularWidget(
                errorMessage!,
                errorColor,
                context,
                size,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        : const SizedBox();
  }
}
