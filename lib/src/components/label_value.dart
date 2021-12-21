import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  const LabelValueWidget({
    Key? key,
    required this.label,
    required this.value,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final String value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final labelColor = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Text(
          label,
          style: textStyle?.copyWith(color: labelColor) ??
              Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: labelColor),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: textStyle ?? Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
