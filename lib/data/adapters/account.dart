import 'package:finanzly_app/models/account.dart';
import 'package:finanzly_app/models/balanceHistory.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final fields = reader.readMap().cast<String, dynamic>();
    return Account(
      id: fields['id'] as String?,
      name: fields['name'] as String?,
      description: fields['description'] as String?,
      createdDate:
          fields['createdDate'] == null ? null : DateTime.parse(fields['createdDate'] as String),
      balanceHistory: (fields['balanceHistory'] as List<dynamic>?)
          ?.map((e) => BalanceHistory.fromJson(e as Map<dynamic, dynamic>))
          .toList()
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer.writeMap({
      'id': obj.id,
      'name': obj.name,
      'description': obj.description,
      'createdDate': obj.createdDate?.toIso8601String(),
      'balanceHistory': obj.balanceHistory?.map((e) => e.toJson()).toList(),
    });
  }
}

@HiveType(typeId: 1)
class BalanceHistoryAdapter extends TypeAdapter<BalanceHistory> {
  @override
  final int typeId = 1;

  @override
  BalanceHistory read(BinaryReader reader) {
    final fields = Map<String, dynamic>.from(reader.readMap());
    return BalanceHistory(
      id: fields['id'] as String?,
      accountId: fields['accountId'] as String?,
      amount: (fields['amount'] as num?)?.toDouble(),
      date: fields['date'] == null ? null : DateTime.parse(fields['date'] as String),
      description: fields['description'] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceHistory obj) {
    writer.writeMap({
      'id': obj.id,
      'accountId': obj.accountId,
      'amount': obj.amount,
      'date': obj.date?.toIso8601String(),
      'description': obj.description,
    });
  }
}
