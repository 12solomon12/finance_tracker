// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/core/failure.dart';
import 'package:finance_tracker/core/typedefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../models/add_transaction.dart';
import '../../../models/budget.dart';

final totalCostsProvider = FutureProvider((ref) {
  final showFinanceRepository = ref.watch(showFinanceRepositoryProvider);
  return showFinanceRepository.getTotalCosts();
});

final budgetCostProvider = StreamProvider((ref) {
  final showFinanceRepository = ref.watch(showFinanceRepositoryProvider);
  return showFinanceRepository.getBudget();
});

final showFinanceRepositoryProvider = Provider((ref) {
  return ShowFinanceRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class ShowFinanceRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ShowFinanceRepository({required this.firestore, required this.auth});

  Future<int> get totalCosts =>
      firestore.collection('transactions').where('price').get().then((value) {
        int totalcosts = 0;
        for (var doc in value.docs) {
          // if (totalcosts == 0) {
          //   totalcosts = AddTransaction.fromMap(doc.data()).price;
          // }
          totalcosts += AddTransaction.fromMap(doc.data()).price;
        }
        return totalcosts;
      });

  Future<int> getTotalCosts() {
    return firestore
        .collection('transactions')
        .where('price')
        .get()
        .then((value) {
      int totalcosts = 0;
      for (var doc in value.docs) {
        // if (totalcosts == 0) {
        //   totalcosts = AddTransaction.fromMap(doc.data()).price;
        // }
        totalcosts += AddTransaction.fromMap(doc.data()).price;
      }
      return totalcosts;
    });
  }

  Stream<int> getBudget() {
    return firestore
        .collection('budget')
        .where('price')
        .snapshots()
        .map((value) {
      int totalBudgets = 0;
      for (var doc in value.docs) {
        // if (totalcosts == 0) {
        //   totalcosts = AddTransaction.fromMap(doc.data()).price;
        // }
        totalBudgets += Budget.fromMap(doc.data()).price;
      }
      return totalBudgets;
    });
  }

  Stream<List<AddTransaction>> getTransactions() {
    return firestore.collection('transactions').snapshots().map((event) {
      List<AddTransaction> transactions = [];
      for (var doc in event.docs) {
        transactions.add(AddTransaction.fromMap(doc.data()));
      }
      return transactions;
    });
  }

  FutureVoid setBudget(int price) async {
    try {
      //var id = const Uuid().v1();
      final budget = {'budget': price};

      return right(await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(budget));
      //   await firestore.collection('budget').doc('1234').set(budget.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  updateBudget(int price) async {
    final newData = {'price': price};

    //Budget budget = Budget().copyWith(price: price);
    return await firestore.collection('budget').doc().update(newData);
  }
}
