// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:finance_tracker/features/show_finance/repository/show_finance_repository.dart';

import '../../../core/utils.dart';
import '../../../models/add_transaction.dart';

final showTransactionsStreamProvider = StreamProvider((ref) {
  final showFinanceController =
      ref.watch(showFinanceControllerProvider.notifier);
  return showFinanceController.getTransactions();
});

final budgetProvider = StateProvider<int?>((ref) => null);

final showFinanceControllerProvider =
    StateNotifierProvider<ShowFinanceController, bool>((ref) {
  final showFinanceRepository = ref.watch(showFinanceRepositoryProvider);
  return ShowFinanceController(
      showFinanceRepository: showFinanceRepository, ref: ref);
});

class ShowFinanceController extends StateNotifier<bool> {
  final ShowFinanceRepository showFinanceRepository;
  final Ref ref;
  ShowFinanceController({
    required this.showFinanceRepository,
    required this.ref,
  }) : super(false);

  Stream<List<AddTransaction>> getTransactions() {
    return showFinanceRepository.getTransactions();
  }

  setBudget(BuildContext context, int price) async {
    state = true;
    final budget = await showFinanceRepository.setBudget(price);
    state = false;
    budget.fold((l) => showSnackBar(context, l.message),
        (r) => ref.read(budgetProvider.notifier).update((state) => price));
  }

  updateBudget(int price) async {
    return showFinanceRepository.updateBudget(price);
  }
}
