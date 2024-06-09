import 'package:finanzly_app/models/balanceHistory.dart';
import 'package:flutter/material.dart';

class Account {
  final String? id;
  final String? name;
  final String? description;
  final DateTime? createdDate;
  final List<BalanceHistory>? balanceHistory;

  const Account({
    this.id,
    this.name,
    this.description,
    this.createdDate,
    this.balanceHistory,
  });

  Account copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdDate,
    List<BalanceHistory>? balanceHistory,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      balanceHistory: balanceHistory ?? this.balanceHistory,
    );
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdDate:
          json['createdDate'] == null ? null : DateTime.parse(json['createdDate'] as String),
      balanceHistory: (json['balanceHistory'] as List<dynamic>?)
          ?.map((e) => BalanceHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdDate': createdDate?.toIso8601String(),
      'balanceHistory': balanceHistory?.map((e) => e.toJson()).toList(),
    };
  }

  double get balance =>
      balanceHistory?.fold<double>(0, (prev, element) => prev + element.amount!) ?? 0;
  String get balanceString => '\$${balance.toStringAsFixed(2)}';

  double get balanceIn =>
      balanceHistory
          ?.where((element) => element.amount! > 0)
          .fold<double>(0, (prev, element) => prev + element.amount!) ??
      0;
  String get balanceInString => '\$${balanceIn.toStringAsFixed(2)}';

  double get balanceOut => balance - balanceIn;
  String get balanceOutString => '\$${balanceOut.toStringAsFixed(2)}';

  Color get balanceColor => balance == 0
      ? Colors.white
      : balance > 0
          ? Colors.green
          : Colors.red;

  double sumOfBalanceUpToIndex(int index) {
    if (index < 0) return 0;
    return balanceHistory
            ?.sublist(0, index + 1)
            .fold<double>(0, (prev, element) => prev + element.amount!) ??
        0;
  }

  String sumOfBalanceUpToIndexString(int index) {
    return '\$${sumOfBalanceUpToIndex(index).toStringAsFixed(2)}';
  }
}
