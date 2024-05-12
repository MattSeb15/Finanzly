import 'package:finanzly_app/common/widgets/keyboard/main.dart';
import 'package:finanzly_app/extensions/num.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanzly App'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            MainKeyboardWidget(
              onKeyPressed: (value) {
                print(value);
              },


            )
          ],
        ),
      ),
    );
  }
}
