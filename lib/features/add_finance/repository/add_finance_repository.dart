// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/add_transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final addFinanceRepositoryProvider = Provider(
    (ref) => AddFinanceRepository(firestore: FirebaseFirestore.instance));

class AddFinanceRepository {
  final FirebaseFirestore firestore;
  AddFinanceRepository({
    required this.firestore,
  });

  addtransaction(
    int price,
    String expense,
    String date,
    String? notes,
  ) async {
    final id = const Uuid().v1();
    AddTransaction addTransaction = AddTransaction(
      id: id,
      price: price,
      expense: expense,
      createdAt: date,
      notes: notes,
    );
    await firestore.collection('transactions').doc(id).set(
          addTransaction.toMap(),
        );
  }
}
