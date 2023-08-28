import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:finance_tracker/core/commons/custom_button.dart';
import 'package:finance_tracker/features/show_finance/controller/show_finance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/commons/custom_textformfield1.dart';
import '../../../theme/pallete.dart';
import '../../profile/screens/profile_screen.dart';
import '../repository/show_finance_repository.dart';
import '../widgets/today.dart';

class ShowFinanceScreen extends ConsumerStatefulWidget {
  const ShowFinanceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowFinanceScreenState();
}

class _ShowFinanceScreenState extends ConsumerState<ShowFinanceScreen>
    with SingleTickerProviderStateMixin {
  // late TabController _controller;
  final TextEditingController budgetController = TextEditingController();
  int? value;

  @override
  void initState() {
    super.initState();
    //  _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  navigateToProfileScreen() {
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }

  setBudgetMoney() {
    ref
        .read(showFinanceControllerProvider)
        .setBudget(int.parse(budgetController.text.toString()));
  }

  setBudget() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Column(
                children: [
                  const Text(
                    'Set Budget... ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  CustomTextFormField1(
                    hintText: 'Enter Budget',
                    labelText: 'Enter Budget',
                    controller: budgetController,
                  ),
                  const Text(
                    'Set duration of Budget',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Slider(
                    divisions: 100,
                    min: 100,
                    max: 900,
                    activeColor: Colors.blue[value ?? 100],
                    inactiveColor: Colors.red,
                    // label: '$value',
                    value: (value ?? 100).toDouble(),
                    onChanged: (val) {
                      setState(() {
                        value = val.round();
                      });
                    },
                  ),
                  Checkbox(value: false, onChanged: (val) {}),
                  // const SizedBox(height: 00),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPressed: () {
                            setBudgetMoney();
                          },
                          text: 'Set Budget',
                          color: Pallete.blueColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.only(),
              decoration: const BoxDecoration(
                color: Pallete.blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context) {
                        return IconButton(
                            onPressed: () => Scaffold.of(context).openDrawer(),
                            icon: const Icon(Icons.segment_sharp));
                      }),
                      InkWell(
                        onTap: navigateToProfileScreen,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              AssetImage('assets/images/person1.jpeg'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  // ref.read(budgetCostProvider).when(data: (data) {
                  //   return Text(
                  //     data.toString(),
                  //     style: const TextStyle(
                  //       color: Pallete.whiteColor,
                  //     ),
                  //   );
                  // }, error: (error, trace) {
                  //   return Center(
                  //     child: Text(error.toString()),
                  //   );
                  // }, loading: () {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }),
                  const SizedBox(height: 10),
                  ref.read(budgetCostProvider).when(data: (data) {
                    return InkWell(
                      onTap: setBudget,
                      child: Text(
                        '\$${data.toString()}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Pallete.whiteColor,
                        ),
                      ),
                    );
                  }, error: (error, trace) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                  const Text(
                    'My Budget',
                    style: TextStyle(
                      fontSize: 20,
                      color: Pallete.whiteColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  ),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        radius: 10,
                        decoration: BoxDecoration(
                            color: Pallete.blackColor,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 3),
                        tabs: const [
                          Tab(text: 'Today'),
                          Tab(text: 'Month'),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          //  controller: _controller,
                          children: [
                            Today(),
                            Center(
                              child: Text('No Data Here yet......'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Row(
                //   children: [

                //     const SizedBox(width: 2),

                //   ],
                // ),
                // child: TabBar(
                //   controller: _controller,
                //   indicatorWeight: 0.1,
                //   tabs: [
                //     // Tab(
                //     //   text: 'Today',
                //     // ),
                //     //  Tab(text: 'Month'),
                //     Container(
                //       alignment: Alignment.center,
                //       height: 30,
                //       width: 100,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Pallete.blackColor, width: 2),
                //         borderRadius: BorderRadius.circular(15),
                //         color: Pallete.whiteColor,
                //       ),
                //       child: const Text('Today'),
                //     ),
                //     Container(
                //       alignment: Alignment.center,
                //       height: 30,
                //       width: 100,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Pallete.blackColor, width: 2),
                //         borderRadius: BorderRadius.circular(15),
                //         color: Pallete.whiteColor,
                //       ),
                //       child: const Text('Month'),
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
