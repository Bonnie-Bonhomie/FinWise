
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction/transaction_ctrl.dart';
import '../../../core/widgets/text_widget.dart';
import '../../view_widgets/transaction_card.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({
    super.key,
    required this.trans,
  });

  final TransactionCtrl trans;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transact = trans.monthlyTransacts;

      if (trans.loading.value) {
        const CircularProgressIndicator();
      }
      if (transact.isEmpty) {
        return Container(
          child: Column(
            children: [
              const Icon(Icons.hourglass_empty),
              const AppText(text: 'Sell More data to make history'),
            ],
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        itemCount: transact.length,
        itemBuilder: (context, index) {
          final tx = transact[index];
          return TransactionCard(tx: tx);
        },
      );
    });
  }
}




// child: DefaultTabController(
//   length: 1,
//
//   child: Column(
//     children: [
//       TabBar(
//
//         tabs: [
//         Tab(
//           child: Obx(() {
//             final month = trans.selectedMonth.value;
//             return AppText(text: DateFormat('MMM yyyy').format(month), textAlign: TextAlign.start,);
//           }),
//
//         )
//       ],
//       ),
//       Expanded(
//         child: TabBarView(children: [
//           TransactionListView(trans: trans),]
//         ),
//       ),
//     ],
//   ),
// )