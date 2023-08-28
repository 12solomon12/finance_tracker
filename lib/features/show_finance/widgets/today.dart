import 'package:finance_tracker/features/show_finance/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../repository/show_finance_repository.dart';

class Today extends ConsumerWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: ref.watch(totalCostsProvider).when(
                      data: (data) => Text(
                        '\$ ${data.toString()}',
                      ),
                      error: (error, stackTrace) {
                        return Text(error.toString());
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )),
          ],
        ),
        const ExpenseList(),
      ],
    );
  }
}
