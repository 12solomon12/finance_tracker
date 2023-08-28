import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Budget {
  final String id;
  final int price;
  final DateTime createdAt;
  Budget({
    required this.id,
    required this.price,
    required this.createdAt,
  });

  Budget copyWith({
    String? id,
    int? price,
    DateTime? createdAt,
  }) {
    return Budget(
      id: id ?? this.id,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as String,
      price: map['price'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Budget.fromJson(String source) =>
      Budget.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Budget(id: $id, price: $price, createdAt: $createdAt)';

  @override
  bool operator ==(covariant Budget other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ price.hashCode ^ createdAt.hashCode;
}
