import 'package:finanzly_app/extensions/num.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? iconSize;
  final TextStyle? textStyle;
  final double? separation;
  final void Function()? onTap;

  const IconTextButton(
      {super.key,
      required this.text,
      required this.icon,
      this.onTap,
      this.iconSize,
      this.textStyle,
      this.separation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 1,
            child: Icon(icon, size: iconSize ?? 30.dp(context)),
          ),
          SizedBox(height: separation ?? 0.5.hp(context)),
          Text(text,
              style: textStyle ??
                  TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
        ],
      ),
    );
  }
}
