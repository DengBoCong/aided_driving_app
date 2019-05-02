import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/models/credit_card_model.dart';
import 'package:aided_driving_app/data/models/payment_model.dart';
import 'package:aided_driving_app/data/models/credit_user_model.dart';

List<CreditCardModel> getCreditCards() {
  List<CreditCardModel> creditCards = [];
  creditCards.add(CreditCardModel(
      "4616900007729988",
      "https://resources.mynewsdesk.com/image/upload/ojf8ed4taaxccncp6pcp.png",
      "06/23",
      "192"));
  creditCards.add(CreditCardModel(
      "3015788947523652",
      "https://resources.mynewsdesk.com/image/upload/ojf8ed4taaxccncp6pcp.png",
      "04/25",
      "217"));
  return creditCards;
}

List<UserModel> getUsersCard() {
  List<UserModel> userCards = [
    UserModel("林沫", "assets/images/person.jpg"),
    UserModel("小陌", "assets/images/person.jpg"),
    UserModel("陌梦", "assets/images/person.jpg"),
  ];

  return userCards;
}

List<PaymentModel> getPaymentsCard() {
  List<PaymentModel> paymentCards = [
    PaymentModel(Icons.receipt, Color(0xFFffd60f), "续费实时管家",
        "05-06", "20:04:16", 251.00, -1),
    PaymentModel(Icons.monetization_on, Color(0xFFff415f), "充值账户钱包",
        "05-02", "14:01:26", 64.00, 1),
    PaymentModel(Icons.location_city, Color(0xFF50f3e2), "个人转账支出",
        "04-26", "10:04:26", 1151.00, -1),
    PaymentModel(Icons.train, Colors.green, "私人医生咨询支出",
        "04-22", "20:04:16", 37.00, -1),
  ];

  return paymentCards;
}
