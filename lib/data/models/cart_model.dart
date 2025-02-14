// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartModel {
  final int id;
  final String sneaker;
  final int count;
  final String user;
  CartModel({
    required this.id,
    required this.sneaker,
    required this.count,
    required this.user,
  });

  CartModel copyWith({
    int? id,
    String? sneaker,
    int? count,
    String? user,
  }) {
    return CartModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      count: count ?? this.count,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
      'count': count,
      'user': user,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int,
      sneaker: map['sneaker'] as String,
      count: map['count'] as int,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartModel(id: $id, sneaker: $sneaker, count: $count, user: $user)';
  }

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sneaker == sneaker &&
        other.count == count &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^ sneaker.hashCode ^ count.hashCode ^ user.hashCode;
  }
}
