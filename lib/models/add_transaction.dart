import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddTransaction {
  final String id;
  final int price;
  final String expense;
  final String createdAt;
  final String? notes;
  AddTransaction({
    required this.id,
    required this.price,
    required this.expense,
    required this.createdAt,
    this.notes,
  });

  AddTransaction copyWith({
    String? id,
    int? price,
    String? expense,
    String? createdAt,
    String? notes,
  }) {
    return AddTransaction(
      id: id ?? this.id,
      price: price ?? this.price,
      expense: expense ?? this.expense,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'expense': expense,
      'createdAt': createdAt,
      'notes': notes,
    };
  }

  factory AddTransaction.fromMap(Map<String, dynamic> map) {
    return AddTransaction(
      id: map['id'] as String,
      price: map['price'] as int,
      expense: map['expense'] as String,
      createdAt: map['createdAt'] as String,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTransaction.fromJson(String source) =>
      AddTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddTransaction(id: $id, price: $price, expense: $expense, createdAt: $createdAt, notes: $notes)';
  }

  @override
  bool operator ==(covariant AddTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        other.expense == expense &&
        other.createdAt == createdAt &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        expense.hashCode ^
        createdAt.hashCode ^
        notes.hashCode;
  }
}
