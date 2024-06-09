import 'package:finanzly_app/extensions/num.dart';
import 'package:finanzly_app/models/key.dart';
import 'package:flutter/material.dart';

class MainKeyboardWidget extends StatefulWidget {
  final Color? primaryColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? mainAxisExtentKeyBoard;
  final BorderRadius? borderRadius;
  final ValueChanged<String?>? onTextChanged;
  const MainKeyboardWidget(
      {super.key,
      this.onTextChanged,
      this.primaryColor,
      this.backgroundColor,
      this.width,
      this.height,
      this.mainAxisExtentKeyBoard,
      this.borderRadius});

  @override
  State<MainKeyboardWidget> createState() => _MainKeyboardWidgetState();
}

class _MainKeyboardWidgetState extends State<MainKeyboardWidget> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    const List<AppKey> numKeyboard = [
      AppKey.normal(KeyId.one, '1'),
      AppKey.normal(KeyId.two, '2'),
      AppKey.normal(KeyId.three, '3'),
      AppKey.normal(KeyId.four, '4'),
      AppKey.normal(KeyId.five, '5'),
      AppKey.normal(KeyId.six, '6'),
      AppKey.normal(KeyId.seven, '7'),
      AppKey.normal(KeyId.eight, '8'),
      AppKey.normal(KeyId.nine, '9'),
      AppKey.normal(KeyId.dot, '.'),
      AppKey.normal(KeyId.zero, '0'),
      AppKey.icon(KeyId.clear, Icons.backspace_outlined),
    ];

    return Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: widget.mainAxisExtentKeyBoard ?? 50,
          ),
          itemCount: numKeyboard.length,
          itemBuilder: (context, index) {
            AppKey key = numKeyboard[index];

            return key.isEmpty()
                ? const SizedBox()
                : Ink(
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (widget.onTextChanged == null) return;
                        transformString(key.transformKey());
                        widget.onTextChanged!(text);
                      },
                      onLongPress: () {
                        if (widget.onTextChanged == null) return;
                        transformStringLongPress(key.transformKey());
                      },
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                      overlayColor: MaterialStateProperty.all(widget.primaryColor != null
                          ? widget.primaryColor!.withOpacity(0.4)
                          : Theme.of(context).colorScheme.primary.withOpacity(0.4)),
                      child: Center(
                        child: key.isNormal()
                            ? Text(
                                key.value,
                                style: TextStyle(
                                  color:
                                      widget.primaryColor ?? Theme.of(context).colorScheme.primary,
                                  fontSize: 13.dp(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Icon(
                                key.value,
                                color: widget.primaryColor ?? Theme.of(context).colorScheme.primary,
                                size: 32,
                              ),
                      ),
                    ),
                  );
          },
        ));
  }

  void transformString(String key) {
    if (text.isEmpty) {
      if (key == '0' || key == 'C' || key == '+') return;
      text += key;
    } else if (key == 'C') {
      text = text.substring(0, text.length - 1);
    } else if (key == '+' || key == '-') {
      if (text.endsWith('+') || text.endsWith('-')) {
        text = text.substring(0, text.length - 1);
      }
      text += key;
    } else if (key != '=') {
      text += key;
    }
  }

  void transformStringLongPress(String transformKey) {
    if (transformKey == 'C') {
      text = '';
      widget.onTextChanged!(text);
    }
  }
}
