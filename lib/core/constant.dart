
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
//Money State
enum MoneyState{
  income, expense
}
//Service Provider
enum ServiceProvider{
  mtn('MTN', 'mtn.jpeg'),
  glo('Glo', 'glo.jpeg'),
  airtel('Airtel', 'airtel.jpeg'),
  nineMobile('9Mobile', 'nineMobile.jpeg');

  final String label;
  final String imgPath;

  const ServiceProvider(this.label, this.imgPath);
}