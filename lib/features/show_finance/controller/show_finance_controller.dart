// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/features/show_finance/repository/show_finance_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/add_transaction.dart';

final showTransactionsStreamProvider = StreamProvider((ref) {
  final showFinanceController = ref.watch(showFinanceControllerProvider);
  return showFinanceController.getTransactions();
});

final showFinanceControllerProvider = Provider((ref) {
  final showFinanceRepository = ref.watch(showFinanceRepositoryProvider);
  return ShowFinanceController(showFinanceRepository: showFinanceRepository);
});

class ShowFinanceController {
  final ShowFinanceRepository showFinanceRepository;
  ShowFinanceController({
    required this.showFinanceRepository,
  });

  Stream<List<AddTransaction>> getTransactions() {
    return showFinanceRepository.getTransactions();
  }

  setBudget(int price) {
    return showFinanceRepository.setBudget(price);
  }

  updateBudget(int price) async {
    return showFinanceRepository.updateBudget(price);
  }
}
