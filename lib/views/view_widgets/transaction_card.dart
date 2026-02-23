
import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/section_divider.dart';
import '../../core/widgets/text_widget.dart';
import '../../data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.tx,
  });

  final TransactionModel tx;

  @override
  Widget build(BuildContext context) {

    final date = tx.time;
    final formatDate = DateFormat('MMMM d').format(date);
    final formatTime = DateFormat('HH:mm').format(date);

    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blue, radius: 20,
            child: Icon(tx.category.icon, color: Colors.white,),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 100,child: Text(tx.title, overflow: TextOverflow.ellipsis,)),
              AppText(text: '$formatTime - $formatDate', textColor: Colors.blue,textSize: 13,)
            ],
          ),
          SectDivider(), SizedBox(width: 60,child: AppText(text: tx.category.label)),
          SectDivider(),
          AppText(text: '${tx.isIncome? '+' : '-'}#${tx.amount}', textColor: tx.isIncome? Colors.black: AppColors.blue,)
        ],
      ),
    );
  }
}
