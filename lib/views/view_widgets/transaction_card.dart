import 'package:data_boot/controllers/transaction/transaction_ctrl.dart';
import 'package:data_boot/core/Routes/routes.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/utils_export.dart';
import 'package:data_boot/viewModel/home_view_model.dart';
import 'package:data_boot/views/view_widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key, required this.tx});

  final TransactionModel tx;
  final viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {


    return Card(
      child: InkWell(
        onTap: (){
          print(tx.category);
          Get.toNamed(Routes.transReceipt, arguments: tx);
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [BoxShadow(color: Theme.of(context).cardColor, )]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.blue,
                radius: 20,
                child: Icon(tx.category.icon),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppText(
                      text: viewModel.formatCurrency(tx.amount),
                      // textColor: Colors.black : AppColors.blue,
                    ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
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
    return Obx(() {
      if(trans.loading.value){
        return SkeletonLoader.shimmerLines(len: 3);
      }
      if(transact.isEmpty){
        return SingleChildScrollView(child: EmptyState(message: trans.error.value,));
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
    });

  }
}



class DepositCard extends StatelessWidget {
  DepositCard({super.key, required this.tx});

  final DepoModel tx;
  final viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
print(tx.fundAt);

    return Card(
      child: InkWell(
        onTap: (){
          Get.toNamed(Routes.depoReceipt, arguments: tx);
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [BoxShadow(color: Theme.of(context).cardColor, offset: Offset(2, 2),)]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.blue,
                radius: 20,
                child: AppText(text: tx.narration[0].toUpperCase(), textColor: Colors.white, textWeigh: FontWeight.bold,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(tx.narration, overflow: TextOverflow.ellipsis),
                  ),
                  AppText(
                    text: viewModel.formatDate(tx.fundAt),
                    textColor: Colors.blue,
                    textSize: 10,
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppText(
                    text: viewModel.formatCurrency(tx.amount),
                    // textColor: Colors.black : AppColors.blue,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: AppColors.primaryLight,
                    ),
                    child: AppText(text: tx.hash, textColor: AppColors.bgColor, textSize: 15),
                  ),
                ],
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}