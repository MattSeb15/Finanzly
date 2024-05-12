import 'package:flutter/material.dart';

class AppKey {
  final KeyId id;
  final KeyType type;
  final dynamic value;

  const AppKey(this.id, this.type, this.value);
  const AppKey.normal(this.id, this.value) : type = KeyType.normal;
  const AppKey.icon(this.id, this.value) : type = KeyType.icon;
  const AppKey.empty() : id = KeyId.empty, type = KeyType.none, value = null;

  isNormal() => type == KeyType.normal && value is String;
  isIcon() => type == KeyType.icon && value is IconData;
  isEmpty() => type == KeyType.none;

  String transformKey() {
    if (isNormal()) {
      return value;
    } else if (isIcon()) {
      switch (value) {
        case Icons.backspace_outlined:
          return 'C';
        case Icons.remove:
          return '-';
        case Icons.add:
          return '+';
        case Icons.check:
          return '=';
        default:
          return '';
      }
    } else {
      return '';
    }
  }

}

enum KeyType { normal, icon, none }

enum KeyId {
  one,
  two,
  three,
  plus,
  four,
  five,
  six,
  minus,
  seven,
  eight,
  nine,
  clear,
  dot,
  zero,
  empty,
  equal
}
