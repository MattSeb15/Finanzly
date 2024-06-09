import 'package:finanzly_app/data/services/hive.dart';
import 'package:finanzly_app/extensions/num.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Create Account'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.hp(context), horizontal: 4.wp(context)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _accountNameController,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          labelText: 'Account name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre de cuenta';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.hp(context)),
                    TextFormField(
                      onFieldSubmitted: (_) async {
                        await _submitForm(context);
                      },
                      controller: _accountDescriptionController,
                      textInputAction: TextInputAction.send,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: 'Account description',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una descripción de cuenta';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5.hp(context)),
                    ElevatedButton(
                      onPressed: () async {
                        await _submitForm(context);
                      },
                      child: const Text('Create Account'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido, muestra un snackbar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));

      //save account to local storage
      await AppHive.createAccount(
          _accountNameController.text.trim(), _accountDescriptionController.text.trim());

      // Navigate back to home screen
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
