import 'package:finanzly_app/common/widgets/button/iconTextButton.dart';
import 'package:finanzly_app/data/services/hive.dart';
import 'package:finanzly_app/extensions/num.dart';
import 'package:finanzly_app/models/account.dart';
import 'package:finanzly_app/models/balanceHistory.dart';
import 'package:finanzly_app/screens/manageFunds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountScreen extends StatelessWidget {
  final String? accountId;
  const AccountScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.hp(context), horizontal: 3.5.wp(context)),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              /*Card(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5.dp(context)),
                  child: Column(
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                                text: account.balanceString,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.dp(context),
                                    color: account.balanceColor)),
                            const TextSpan(text: '\n'),
                            TextSpan(
                                children: [
                                  TextSpan(text: 'Ingresos: ${account.balanceInString}'),
                                  const TextSpan(text: ' | '),
                                  TextSpan(text: 'Egresos: ${account.balanceOutString}'),
                                ],
                                style: TextStyle(
                                  fontSize: 7.dp(context),
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                )),
                          ],
                          style: TextStyle(fontSize: 15.dp(context)),
                        ),
                      ),
                      SizedBox(height: 2.hp(context)),
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                        title: Text(
                          account.name ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        subtitle: Text(account.description ?? '-', maxLines: 2),
                        leading: CircleAvatar(
                          radius: 15.dp(context),
                          child: Text(account.name![0].toUpperCase() ?? '-',
                              style: TextStyle(fontSize: 10.dp(context))),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageFundsScreen(
                                    account: account,
                                  ))),
                        ),
                      ),
                      SizedBox(height: 2.hp(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconTextButton(
                              onTap: () {},
                              text: 'Transferir dinero',
                              icon: Icons.compare_arrows_rounded),
                          IconTextButton(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageFundsScreen(
                                        account: account,
                                      ))),
                              text: 'Gestionar fondos',
                              icon: Icons.attach_money_rounded),
                        ],
                      )
                    ],
                  ),
                ),
              ),*/
              ValueListenableBuilder(
                  valueListenable: AppHive.accBox.listenable(),
                  builder: (context, box, widget) {
                    Account account = box.values.firstWhere((element) => element.id == accountId);
                    List<BalanceHistory>? balanceHistory = account.balanceHistory;
                    //order by date
                    List<BalanceHistory>? sortedList = balanceHistory?.toList()
                      ?..sort((a, b) => b.date!.compareTo(a.date!));
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 4,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 5.dp(context)),
                            child: Column(
                              children: [
                                Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: account.balanceString,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.dp(context),
                                              color: account.balanceColor)),
                                      const TextSpan(text: '\n'),
                                      TextSpan(
                                          children: [
                                            TextSpan(text: 'Ingresos: ${account.balanceInString}'),
                                            const TextSpan(text: ' | '),
                                            TextSpan(text: 'Egresos: ${account.balanceOutString}'),
                                          ],
                                          style: TextStyle(
                                            fontSize: 7.dp(context),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.5),
                                          )),
                                    ],
                                    style: TextStyle(fontSize: 15.dp(context)),
                                  ),
                                ),
                                SizedBox(height: 2.hp(context)),
                                ListTile(
                                  tileColor:
                                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                  title: Text(
                                    account.name ?? '-',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(account.description ?? '-', maxLines: 2),
                                  leading: CircleAvatar(
                                    radius: 15.dp(context),
                                    child: Text(account.name![0].toUpperCase(),
                                        style: TextStyle(fontSize: 10.dp(context))),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => {},
                                  ),
                                ),
                                SizedBox(height: 2.hp(context)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconTextButton(
                                        onTap: () {},
                                        text: 'Transferir dinero',
                                        icon: Icons.compare_arrows_rounded),
                                    IconTextButton(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ManageFundsScreen(
                                                      account: account,
                                                    ))),
                                        text: 'Gestionar fondos',
                                        icon: Icons.attach_money_rounded),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.hp(context)),
                        Text('Movimientos (${balanceHistory?.length ?? 0})',
                            style:
                                TextStyle(fontSize: 10.dp(context), fontWeight: FontWeight.bold)),
                        SizedBox(height: 2.hp(context)),
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 42.hp(context),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: balanceHistory != null && balanceHistory.isNotEmpty
                              ? ListView.separated(
                                  dragStartBehavior: DragStartBehavior.start,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    BalanceHistory? balance = sortedList?[index];
                                    return balance != null
                                        ? ListTile(
                                            /* leading: Text('${balanceHistory.length - (index)}',
                                                style: TextStyle(
                                                    fontSize: 9.5.dp(context),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.8))),*/
                                            title: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text('${balanceHistory.length - (index)}.',
                                                    style: TextStyle(
                                                        fontSize: 8.dp(context),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.8))),
                                                SizedBox(width: 1.wp(context)),
                                                Icon(Icons.date_range_rounded,
                                                    size: 17,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.5)),
                                                SizedBox(width: 1.wp(context)),
                                                Text(balance.parsedDate,
                                                    style: TextStyle(fontSize: 7.dp(context))),
                                                SizedBox(width: 3.wp(context)),
                                                Icon(Icons.access_time_rounded,
                                                    size: 17,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.5)),
                                                SizedBox(width: 1.wp(context)),
                                                Text(balance.parsedTime,
                                                    style: TextStyle(fontSize: 7.dp(context))),
                                              ],
                                            ),
                                            subtitle: Text(
                                              balance.description ?? 'Sin detalle',
                                              maxLines: 1,
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(balance.parsedAmount,
                                                    style: TextStyle(
                                                        fontSize: 8.5.dp(context),
                                                        fontWeight: FontWeight.bold,
                                                        color: balance.statusColor)),
                                                Text(
                                                    account.sumOfBalanceUpToIndexString(
                                                        balanceHistory.length - (index + 1)),
                                                    style: TextStyle(
                                                      fontSize: 7.dp(context),
                                                    )),
                                              ],
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.2));
                                  },
                                  itemCount: balanceHistory.length,
                                )
                              : Center(
                                  child: Text(
                                  'Sin movimientos',
                                  style: TextStyle(
                                    fontSize: 11.dp(context),
                                  ),
                                )),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
