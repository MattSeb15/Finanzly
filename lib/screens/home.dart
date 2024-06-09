import 'package:finanzly_app/common/widgets/card/account.dart';
import 'package:finanzly_app/data/services/hive.dart';
import 'package:finanzly_app/extensions/num.dart';
import 'package:finanzly_app/screens/createAccount.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CreateAccountScreen())),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.hp(context), horizontal: 3.5.wp(context)),
        child: SizedBox(
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: const [
                  TextSpan(text: 'Bienvenido', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' a Finanzly', style: TextStyle(fontWeight: FontWeight.normal)),
                ],
                style: TextStyle(fontSize: 15.dp(context), fontWeight: FontWeight.bold),
              ),
            ),
            Text('Cuentas:',
                style: TextStyle(fontSize: 15.dp(context), fontWeight: FontWeight.bold)),
            SizedBox(height: 2.hp(context)),
            /*            Consumer<AccountsProvider>(builder: (context, accProvider, child) {
              accProvider.getAccounts();
              return Column(
                children: accProvider.accounts
                    .map((account) => AccountCard(accountId: account.id!))
                    .toList(),
              );
            }),*/
            ValueListenableBuilder(
                valueListenable: AppHive.accBox.listenable(),
                builder: (context, box, widget) {
                  if (box.values.isEmpty) {
                    return const Text('No hay cuentas');
                  }
                  return Column(
                    children:
                        box.values.map((account) => AccountCard(accountId: account.id!)).toList(),
                  );
                })
          ]),
        ),
      ),
    );
  }
}
