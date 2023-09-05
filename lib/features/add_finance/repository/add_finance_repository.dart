// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/core/failure.dart';
import 'package:finance_tracker/core/typedefs.dart';
import 'package:finance_tracker/models/add_transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

final addFinanceRepositoryProvider = Provider((ref) => AddFinanceRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class AddFinanceRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AddFinanceRepository({required this.firestore, required this.auth});

  FutureVoid addtransaction(
    int price,
    String expense,
    String date,
    String? notes,
  ) async {
    try {
      final id = const Uuid().v1();
      AddTransaction addTransaction = AddTransaction(
        id: id,
        price: price,
        expense: expense,
        createdAt: date,
        notes: notes,
      );
      await firestore.collection('users').doc(auth.currentUser!.uid).get();
      final newBudget = {'budget': price};
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(newBudget);
      final transaction = await firestore
          .collection('transactions')
          .doc(id)
          .set(addTransaction.toMap());
      return right(transaction);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
