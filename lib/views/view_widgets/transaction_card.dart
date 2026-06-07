import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key, required this.tx});

  final TransactionModel tx;
  final viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    // DateTime date = DateT;
    // final date = tx.time;
    // final formatDate = DateFormat('MMMM d').format(date);
    // final formatTime = DateFormat('HH:mm').format(date);

    return InkWell(
      onTap: (){
        Get.toNamed(Routes.transReceipt, arguments: tx);
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Theme.of(context).cardColor, offset: Offset(2, 4),)]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blue,
              radius: 20,
              child: AppText(text: tx.modelableType[0].toUpperCase(), textColor: Colors.white, textWeigh: FontWeight.bold,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(tx.modelableType, overflow: TextOverflow.ellipsis),
                ),
                AppText(
                  text: viewModel.formatDate(tx.purchaseAt),
                  textColor: Colors.blue,
                  textSize: 10,
                ),
              ],
            ),

            Column(
              children: [
                AppText(
                    text: viewModel.formatCurrency(tx.amount),
                    // textColor: Colors.black : AppColors.blue,
                  ),
                Container(
                  padding: const EdgeInsets.fromLTRB(3, 2, 3, 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: tx.apiStatus.color.withValues(alpha: 0.5),
                  ),
                  child: AppText(text: tx.apiStatus.label, textColor: AppColors.bgColor, textSize: 10),
                ),
              ],
            ),
            //
          ],
        ),
      ),
    );
  }
}



class BuildTransaction extends StatelessWidget {
  const BuildTransaction({
    super.key,
    required this.trans,
  });

  final TransactionCtrl trans;

  @override
  Widget build(BuildContext context) {
    final transact = trans.transactionList;
    int getLen(){
      int len;
      if(transact.length < 3){
        len = transact.length;
      }else{
        len = 3;
      }
      return len;
    }
    if(trans.loading.value){
      return SkeletonLoader.shimmerLines(len: 3);
    } else if(transact.isEmpty){
      return SingleChildScrollView(
        child: EmptyState(message: trans.error.value,)
      );
    }
    //Add animation
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: getLen(),
      itemBuilder: (context, index) {
        final tx = transact[index];
        return TransactionCard(tx: tx);
      },
    );
  }
}
