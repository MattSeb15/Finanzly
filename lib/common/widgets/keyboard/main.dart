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
  final ValueChanged<String?>? onKeyPressed;
  const MainKeyboardWidget(
      {super.key,
      this.onKeyPressed,
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
      AppKey.icon(KeyId.clear, Icons.backspace_outlined),
      AppKey.normal(KeyId.four, '4'),
      AppKey.normal(KeyId.five, '5'),
      AppKey.normal(KeyId.six, '6'),
      AppKey.icon(KeyId.minus, Icons.remove),
      AppKey.normal(KeyId.seven, '7'),
      AppKey.normal(KeyId.eight, '8'),
      AppKey.normal(KeyId.nine, '9'),
      AppKey.icon(KeyId.plus, Icons.add),
      AppKey.normal(KeyId.dot, '.'),
      AppKey.normal(KeyId.zero, '0'),
      AppKey.empty(),
      AppKey.icon(KeyId.equal, Icons.check),
    ];

    return Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
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
                      color: widget.backgroundColor ?? Theme.of(context).colorScheme.secondary,
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (widget.onKeyPressed == null) return;
                        widget.onKeyPressed!(key.transformKey());
                        transformString(key.transformKey());
                        debugPrint("text: $text");
                      },
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                      overlayColor: MaterialStateProperty.all(
                          widget.primaryColor ?? Theme.of(context).colorScheme.primaryContainer),
                      child: Center(
                        child: key.isNormal()
                            ? Text(
                                key.value,
                                style: TextStyle(
                                  color: widget.primaryColor ??
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Icon(
                                key.value,
                                color: widget.primaryColor ??
                                    Theme.of(context).colorScheme.onSecondary,
                                size: 32,
                              ),
                      ),
                    ),
                  );
          },
        ));
  }

  void transformString(String key) {
    if (text.isEmpty && key == '0' || text.isEmpty && key == 'C') return;

    if (key == 'C') {
      text = text.substring(0, text.length - 1);
    } else if (key == '=') {
      text = text;
    } else if (key == '+') {
      text += '+';
    } else if (key == '-') {
      text += '-';
    } else {
      text += key;
    }
  }
}
