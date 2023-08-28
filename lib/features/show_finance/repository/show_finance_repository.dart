// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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
  return ShowFinanceRepository(firestore: FirebaseFirestore.instance);
});

class ShowFinanceRepository {
  final FirebaseFirestore firestore;
  ShowFinanceRepository({
    required this.firestore,
  });

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

  setBudget(int price) async {
    var id = const Uuid().v1();
    Budget budget = Budget(id: id, price: price, createdAt: DateTime.now());
    return await firestore.collection('budget').doc('1234').set(budget.toMap());
  }

  updateBudget(int price) async {
    final newData = {'price': price};

    //Budget budget = Budget().copyWith(price: price);
    return await firestore.collection('budget').doc().update(newData);
  }
}
