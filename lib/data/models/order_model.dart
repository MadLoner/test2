// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  final int id;
  final DateTime created_at;
  final String user;
  final double sum;
  final String address;
  OrderModel({
    required this.id,
    required this.created_at,
    required this.user,
    required this.sum,
    required this.address,
  });

  OrderModel copyWith({
    int? id,
    DateTime? created_at,
    String? user,
    double? sum,
    String? address,
  }) {
    return OrderModel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      user: user ?? this.user,
      sum: sum ?? this.sum,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at.millisecondsSinceEpoch,
      'user': user,
      'sum': sum,
      'address': address,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      user: map['user'] as String,
      sum: map['sum'] as double,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, created_at: $created_at, user: $user, sum: $sum, address: $address)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.user == user &&
        other.sum == sum &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        user.hashCode ^
        sum.hashCode ^
        address.hashCode;
  }
}
