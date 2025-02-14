// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PopularModel {
  final int id;
  final String sneaker;
  PopularModel({
    required this.id,
    required this.sneaker,
  });

  PopularModel copyWith({
    int? id,
    String? sneaker,
  }) {
    return PopularModel(
      id: id ?? this.id,
      sneaker: sneaker ?? this.sneaker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sneaker': sneaker,
    };
  }

  factory PopularModel.fromMap(Map<String, dynamic> map) {
    return PopularModel(
      id: map['id'] as int,
      sneaker: map['sneaker'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PopularModel.fromJson(String source) =>
      PopularModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PopularModel(id: $id, sneaker: $sneaker)';

  @override
  bool operator ==(covariant PopularModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.sneaker == sneaker;
  }

  @override
  int get hashCode => id.hashCode ^ sneaker.hashCode;
}
