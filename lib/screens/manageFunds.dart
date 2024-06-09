import 'package:finanzly_app/data/services/hive.dart';
import 'package:finanzly_app/extensions/num.dart';
import 'package:finanzly_app/models/account.dart';
import 'package:flutter/material.dart';


import '../common/widgets/keyboard/main.dart';

class ManageFundsScreen extends StatefulWidget {
  final Account account;
  const ManageFundsScreen({super.key, required this.account});

  @override
  State<ManageFundsScreen> createState() => _ManageFundsScreenState();
}

class _ManageFundsScreenState extends State<ManageFundsScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String text = '';
  bool isAdding = true;
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            //SPANISH: Administrar fondos de ${widget.account.name}
            title: Text('Administrar fondos de ${widget.account.name}',
                style: TextStyle(fontSize: 9.dp(context))),
            actions: [
              IconButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          await saveBalanceHistory(context);
                        },
                  icon: Icon(Icons.save_rounded, color: Theme.of(context).colorScheme.primary))
            ],
          ),
          body: AnimatedContainer(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isAdding ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                  isAdding ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 100.hp(context),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.5.hp(context)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: 0,
                      child: Icon(
                        isAdding ? Icons.add_rounded : Icons.remove_rounded,
                        size: 250.dp(context),
                        color: Theme.of(context).colorScheme.background.withOpacity(0.4),
                      )),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              isAdding = !isAdding;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: AnimatedDefaultTextStyle(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isAdding ? Colors.green : Colors.red,
                                  fontSize: 32.dp(context),
                                  fontWeight: isAdding ? FontWeight.bold : FontWeight.w500,
                                ),
                                duration: const Duration(milliseconds: 300),
                                child: Text(generatedText())),
                          ),
                        ),
                        SizedBox(height: 5.hp(context)),
                        SizedBox(
                          width: 80.wp(context),
                          child: TextField(
                              controller: _descriptionController,
                              style: TextStyle(
                                fontSize: 9.dp(context),
                              ),
                              maxLines: 2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.dp(context)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.dp(context)),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Detalle',
                                contentPadding: const EdgeInsets.all(10),
                                suffixIcon: const Icon(Icons.comment_rounded),
                              )),
                        ),
                        SizedBox(height: 0.5.hp(context)),
                        SizedBox(
                          width: 80.wp(context),
                          child: TextField(
                              controller: _amountController,
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 13.dp(context),
                              ),
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.dp(context)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.dp(context)),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '0',
                                contentPadding: const EdgeInsets.all(10),
                                suffixIcon: const Icon(Icons.attach_money_rounded),
                              )),
                        ),
                        SizedBox(height: 2.hp(context)),
                        MainKeyboardWidget(
                          width: 85.wp(context),
                          onTextChanged: (value) {
                            setState(() {
                              text = value!;
                              _amountController.text = text;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  String generatedText() => text.isEmpty
      ? '${isAdding ? '+ ' : '- '}0.00\$'
      : '${isAdding ? '+ ' : '- '}${double.parse(text).toStringAsFixed(2)}\$';

  Future<void> saveBalanceHistory(BuildContext context) async {
    if (text.isEmpty) return;
    isSaving = true;
    final finalText = isAdding ? text : '-$text';
    final double amount = double.parse(finalText);
    String description = _descriptionController.text.trim();
    if(description.isEmpty) description = isAdding ? 'Depósito sin detalle' : 'Retiro sin detalle';
    final String? accountId = widget.account.id;
    await AppHive.updateAccountBalance(accountId, amount, description);

    isSaving = false;
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
