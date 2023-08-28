// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_tracker/features/add_finance/repository/add_finance_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/add_transaction.dart';

final addFinanceControllerProvider = Provider((ref) {
  final addFinanceRepository = ref.watch(addFinanceRepositoryProvider);
  return AddFinanceController(addFinanceRepository: addFinanceRepository);
});

class AddFinanceController {
  final AddFinanceRepository addFinanceRepository;
  AddFinanceController({
    required this.addFinanceRepository,
  });

  addtransaction(int price, String expense, String date, String notes) async {
    return addFinanceRepository.addtransaction(price, expense, date, notes);
  }
}
