import 'package:finance_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/show_finance_controller.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NumberFormat formatting =
        NumberFormat.currency(decimalDigits: 2, symbol: '\$');
    return Container(
      height: 250,
      child: ref.watch(showTransactionsStreamProvider).when(
          data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/person1.jpeg'),
                  ),
                  title: Text(
                    data[i].expense,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    formatting.format(
                      data[i].price,
                    ),
                    //    '\$${data[i].price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Pallete.blueColor,
                    ),
                  ),
                );
              }),
          error: (error, trace) {
            print(trace);
            print(error);

            return Center(
              child: Text('${error.toString()} - $trace'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
