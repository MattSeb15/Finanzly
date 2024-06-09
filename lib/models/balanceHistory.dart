import 'package:flutter/material.dart';

class BalanceHistory {
  final String? id;
  final String? accountId;
  final double? amount;
  final DateTime? date;
  final String? description;

  const BalanceHistory({
    this.id,
    this.accountId,
    this.amount,
    this.date,
    this.description,
  });

  BalanceHistory copyWith({
    String? id,
    String? accountId,
    double? amount,
    DateTime? date,
    String? description,
  }) {
    return BalanceHistory(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  factory BalanceHistory.fromJson(Map<dynamic, dynamic> json) {
    return BalanceHistory(
      id: json['id'] as String?,
      accountId: json['accountId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountId': accountId,
      'amount': amount,
      'date': date?.toIso8601String(),
      'description': description,
    };
  }

  String get parsedFullDate {
    final day = date!.day.toString().padLeft(2, '0');
    final month = date!.month.toString().padLeft(2, '0');
    final year = date!.year.toString().padLeft(2, '0');
    final hour = date!.hour.toString().padLeft(2, '0');
    final minute = date!.minute.toString().padLeft(2, '0');
    return '$day/$month/$year - $hour:$minute';
  }

  String get parsedDate {
    final day = date!.day.toString().padLeft(2, '0');
    final month = date!.month.toString().padLeft(2, '0');
    final year = date!.year.toString().padLeft(2, '0');
    return '$day/$month/$year';
  }

  String get parsedTime {
    final hour = date!.hour.toString().padLeft(2, '0');
    final minute = date!.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool get isDeposit => amount! > 0;
  Color get statusColor => isDeposit ? Colors.green : Colors.red;
  String get parsedAmount => '${amount! > 0 ? '+' : '-'}\$${amount!.abs().toStringAsFixed(2)}';
}
