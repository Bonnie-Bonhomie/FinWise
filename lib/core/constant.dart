
import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

// Service Categories
enum Categories {
  airtime('Airtime', Icons.call),
  data('Data', Icons.data_exploration_outlined),
  cable('TV', Icons.cable),
  electricity('Electricity', Icons.electric_bolt),
  education('Education', Icons.school_outlined),
  solar('Solar', Icons.emoji_transportation_outlined),
  chowDeck('ChowDeck',  Icons.deck),
  invitation('invitation', Icons.insert_invitation),
  gift('Gift Card', Icons.card_giftcard);

  final String label;
  final IconData icon;

  const Categories(this.label, this.icon);
}
//analysis Provider
enum ChartPeriod{
  daily, weekly, monthly, yearly
}

enum Frequency{daily, weekly, monthly;

  static Frequency fromString(String value) {
    return Frequency.values.firstWhere(
          (e) => e.name == value.toLowerCase(),
      orElse: () => Frequency.daily,
    );
  }
}
//Money State
enum MoneyState{
  income, expense
}
//Service Provider
enum ServiceProvider{
  mtn('MTN', 'mtn.jpeg'),
  glo('Glo', 'glo.jpeg'),
  airtel('Airtel', 'airtel.jpeg'),
  nineMobile('9Mobile', 'et.jpeg');

  final String label;
  final String imgPath;

  const ServiceProvider(this.label, this.imgPath);
}

enum TransactionStatus{
  pending('Pending', AppColors.pending),
  declined('Declined', AppColors.declined),
  complete('Completed', AppColors.primary);

  final String label;
  final Color color;
  const TransactionStatus(this.label, this.color);
}