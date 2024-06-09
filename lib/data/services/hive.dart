import 'package:finanzly_app/models/account.dart';
import 'package:finanzly_app/models/balanceHistory.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class AppHive {
  static Box accBox = Hive.box('accounts');

  static Future<void> saveData(String key, dynamic value) async {
    await accBox.put(key, value);
  }

  static dynamic getData(String key) {
    return accBox.get(key);
  }

  static Future<void> removeData(String key) async {
    await accBox.delete(key);
  }

  static Future<void> clearData() async {
    await accBox.clear();
  }

  static Future<void> createAccount(String accName, String accDesc) async {
    var uuid = const Uuid();
    String accId = uuid.v4();
    Account account = Account(
      id: accId,
      name: accName,
      description: accDesc,
      createdDate: DateTime.now(),
      balanceHistory: [],
    );

    await accBox.put(accId, account);
  }

  static Future<void> updateAccount(Account account) async {
    await accBox.put(account.id, account);
  }

  static Future<void> deleteAccount(String accountId) async {
    await accBox.delete(accountId);
  }

  static Future<void> updateAccountBalance(
      String? accountId, double amount, String description) async {
    if (accountId == null) return;
    var uuid = const Uuid();
    Account? account = accBox.get(accountId);
    if (account == null) return;
    account.balanceHistory!.add(BalanceHistory(
      id: uuid.v4(),
      accountId: accountId,
      amount: amount,
      date: DateTime.now(),
      description: description,
    ));
    await accBox.put(accountId, account);
  }
}
