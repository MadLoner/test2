// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrdersneakerModel {
  final String id;
  final String sneaker;
  final int orderid;
  final int count;
  OrdersneakerModel({
    required this.id,
    required this.sneaker,
    required this.orderid,
    required this.count,
  });

  OrdersneakerModel copyWith({
    String? id,
    String? sneaker,
    int? orderid,
    int? count,
  }) {
    return OrdersneakerModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
      orderid: orderid ?? this.orderid,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
      'orderid': orderid,
      'count': count,
    };
  }

  factory OrdersneakerModel.fromMap(Map<String, dynamic> map) {
    return OrdersneakerModel(
      id: map['id'] as String,
      sneaker: map['sneaker'] as String,
      orderid: map['orderid'] as int,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersneakerModel.fromJson(String source) =>
      OrdersneakerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdersneakerModel(id: $id, sneaker: $sneaker, orderid: $orderid, count: $count)';
  }

  @override
  bool operator ==(covariant OrdersneakerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sneaker == sneaker &&
        other.orderid == orderid &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^ sneaker.hashCode ^ orderid.hashCode ^ count.hashCode;
  }
}
