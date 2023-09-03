// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_tracker/core/typedefs.dart';
import 'package:finance_tracker/features/add_finance/repository/add_finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils.dart';

final addFinanceControllerProvider =
    StateNotifierProvider<AddFinanceController, bool>((ref) {
  final addFinanceRepository = ref.watch(addFinanceRepositoryProvider);
  return AddFinanceController(addFinanceRepository: addFinanceRepository);
});

class AddFinanceController extends StateNotifier<bool> {
  final AddFinanceRepository addFinanceRepository;
  AddFinanceController({
    required this.addFinanceRepository,
  }) : super(false);

  void addtransaction(BuildContext context, int price, String expense,
      String date, String notes) async {
    state = true;
    final transaction =
        await addFinanceRepository.addtransaction(price, expense, date, notes);
    state = false;
    transaction.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, 'Transaction Added'));
  }
}
