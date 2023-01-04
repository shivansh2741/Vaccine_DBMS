import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaccination_dbms/main.dart';
import 'package:vaccination_dbms/model/payment.dart';
import 'package:http/http.dart' as http;

class PaymentList extends StatefulWidget {
  const PaymentList({Key? key}) : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  List<Payment> result = [];
  bool cond = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentDetails();
  }

  Future<void> getPaymentDetails() async {
    var url =
        Uri.parse('https://gautam131714.000webhostapp.com/getPayment.php');
    var response = await http.get(url);
    if (response.body != "") {
      var tt = jsonDecode(response.body);
      for (int i = 0; i < tt.length; i++) {
        Payment temp = Payment(
          amount: tt[i]['amount'],
          email: tt[i]['email'],
          payment_id: tt[i]['payment_id'],
          vaccine_code: tt[i]['vaccine_code'],
          date: DateTime.parse(tt[i]['date']),
        );
        result.add(temp);
      }
      cond = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment List"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (cond) const CircularProgressIndicator(),
          Flexible(
              child: ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, i) {
              return Card(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Vaccine Name: " +
                          vaccine_map[result[i].vaccine_code]!.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Email: " + result[i].email),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Amount Paid: " + result[i].amount),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date Of Vaccination: " +
                            result[i].date.toString().substring(0, 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Payment ID: " + result[i].payment_id),
                    ),
                  ],
                ),
              ));
            },
          )),
        ],
      ),
    );
  }
}
