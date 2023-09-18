import 'package:date_time_picker/date_time_picker.dart';

import 'package:finance_tracker/features/add_finance/controller/add_finance_controller.dart';
import 'package:finance_tracker/features/add_finance/widgets/list_item.dart';
import 'package:finance_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/commons/custom_button.dart';
import '../../../core/commons/custom_textformfield.dart';
import '../../../core/constants/loader.dart';

class AddFinanceScreen extends ConsumerStatefulWidget {
  const AddFinanceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddFinanceScreenState();
}

class _AddFinanceScreenState extends ConsumerState<AddFinanceScreen> {
  String? value;
  // Time _time = Time(hour: 11, minute: 30, second: 20);

  // void onTimeChanged(Time newTime) {
  //   setState(() {
  //     _time = newTime;
  //   });
  // }

  final TextEditingController priceController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  addFinanceTransaction(int price, String expense, String note, String date) {
    ref
        .watch(addFinanceControllerProvider.notifier)
        .addtransaction(context, price, expense, date, note);
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    expenseController.dispose();
    dateController.dispose();
    notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(addFinanceControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Add Transacttion',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Chip(
                      label: Text(
                        'GHC',
                        style: TextStyle(color: Pallete.whiteColor),
                      ),
                      backgroundColor: Pallete.blueColor,
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 200,
                      child: CustomTextFormField(
                        hintText: 'Enter Price',
                        controller: priceController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ListItem(
                    hintText: 'Enter Expense', controller: expenseController),
                // SfDateRangePicker(
                //   selectionMode: DateRangePickerSelectionMode.single,
                // ),
                // Text(
                //     "${_time.hour}:${_time.minute}:${_time.second} ${_time.period.name}"
                //         .toUpperCase(),
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize: 20,
                // //     )
                //     //  Theme.of(context).textTheme.bodySmall,
                //     ),
                const Text(
                  'Please make sure you pick a date in order to confirm the date even if is today',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  // initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    // if (date.weekday == 6 || date.weekday == 7) {
                    //   return false;
                    // }

                    return true;
                  },
                  onChanged: (val) {
                    print(val);
                    setState(() {
                      value = val;
                    });
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      value = val!;
                    });
                  },
                ),
                ListItem(hintText: 'Add Notes', controller: notesController),
                const SizedBox(height: 35),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      color: Pallete.blueColor,
                      onPressed: () => addFinanceTransaction(
                        int.parse(priceController.text),
                        expenseController.text,
                        notesController.text,
                        value!,
                        //DateTime.pars(dateController.text),
                      ),
                      child: isLoading
                          ? const Loader()
                          : const Text('Add Transaction'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
