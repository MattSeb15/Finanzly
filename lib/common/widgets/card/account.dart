import 'package:finanzly_app/data/services/hive.dart';
import 'package:finanzly_app/models/account.dart';
import 'package:finanzly_app/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class AccountCard extends StatelessWidget {
  final String accountId;
  const AccountCard({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: AppHive.accBox.listenable(),
            builder: (context, box, widget) {
              Account account = box.values.firstWhere((element) => element.id == accountId);
              return Card(
                  child: ListTile(
                onLongPress: () {
                  //open a bottom sheet with options
                  Scaffold.of(context).showBottomSheet((context) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Cuenta: ${account.name}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Eliminar cuenta'),
                              onTap: () async {
                                await AppHive.deleteAccount(accountId);
                                if (!context.mounted) return;
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Editar cuenta'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ));
                },
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen(accountId: account.id))),
                isThreeLine: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(account.balanceString,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: account.balanceColor)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(accountId, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        Text(
                          account.name ?? '-',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle:
                    Text(account.description ?? '-', overflow: TextOverflow.ellipsis, maxLines: 2),
              ));
            }),
      ],
    );
  }
}
