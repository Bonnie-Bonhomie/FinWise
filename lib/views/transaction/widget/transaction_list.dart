import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/loading_skeleton.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transaction/transaction_ctrl.dart';
import '../../../utils/widgets/text_widget.dart';
import '../../view_widgets/transaction_card.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({super.key, required this.trans});

  final TransactionCtrl trans;

  // final bool loading;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transact = trans.transactionList;
      if (trans.loading.value == true) {
        return Center(child: SkeletonLoader.shimmerLines(len: 5));
      }

      if (transact.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('Assets/images/green_empty.png'),
              height: 100,
              width: 100,
            ),
            AppText(text: 'Oops!', textSize: 18),
            AppText(text: trans.error.value, textSize: 12),
          ],
        );
      }
      return ListView.builder(
        controller: trans.scrollCtrl,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        itemCount: trans.loadMore.value ? transact.length + 1 :transact.length,
        itemBuilder: (context, index) {
          if (index == transact.length) {
            return Center(child: CircularProgressIndicator());
          }
          final tx = transact[index];

          return AnimatedCard(
            index: index,
            child: TransactionCard(tx: tx),
          );
        },
      );
    });
  }
}

class DepositListView extends StatelessWidget {
  const DepositListView({super.key, required this.trans});

  final TransactionCtrl trans;

  // final bool loading;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final transact = trans.allDeposit;
      if (trans.loadingDepo.value == true) {
        return Center(child: SkeletonLoader.shimmerLines(len: 5));
      }

      if (transact.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('Assets/images/green_empty.png'),
              height: 100,
              width: 100,
            ),
            AppText(text: 'Oops!', textSize: 18),
            AppText(text: trans.error.value, textSize: 12),
          ],
        );
      }
      return ListView.builder(
        controller: trans.scrollCtrl,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        itemCount: transact.length,
        itemBuilder: (context, index) {
          final tx = transact[index];
          return AnimatedCard(
            index: index,
            child: DepositCard(tx: tx),
          );
        },
      );
    });
  }
}
