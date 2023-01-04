import 'package:flutter/material.dart';
import 'package:vaccination_dbms/func.dart';
import 'package:vaccination_dbms/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vaccination_dbms/profile.dart';
import 'package:loader_overlay/loader_overlay.dart';

late Razorpay _razorpay;
bool cond = false;
String id = "";
String tempcode = "", tempcost = "", tempdate = "";
int ind = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    id = response.paymentId.toString();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Success"),
      ),
    );
    addPaymentRecord(id, curr_email, tempcode, tempcost, tempdate);
    stockList[ind].stockTotal--;
    setState(() {});
    editStockAmount(
      (stockList[ind].stockTotal).toString(),
      stockList[ind].stockId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "ERROR: " + response.code.toString() + " - " + response.message!),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "EXTERNAL WALLET: " + response.walletName!,
        ),
      ),
    );
  }

  void openCheckout(int price, String name) async {
    var options = {
      'key': 'rzp_test_o4eo3gVWbgAyru',
      'amount': price,
      'name': "Vaccine",
      'description': name,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> update() async {
    await makeStockList();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("HomePage"),
          leading: Hero(
            tag: "logo",
            child: Image.asset(
              'images/vacc.png',
              width: 100,
              height: 100,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "All The Available Stocks",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            if (isLoading) const CircularProgressIndicator(),
            Flexible(
              child: ListView.builder(
                itemCount: stockList.length,
                itemBuilder: (context, i) {
                  if (stockList[i].expiry.isBefore(
                        DateTime.now(),
                      )) {
                    return Container();
                  } else if (stockList[i].stockTotal <= 0) {
                    return Container();
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.vaccines),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: " +
                                    vaccine_map[stockList[i].vaccineCode]!
                                        .name),
                                Text("Efficacy: " +
                                    vaccine_map[stockList[i].vaccineCode]!
                                        .efficacy +
                                    "%"),
                                Text(
                                  "Expiry Date: " +
                                      stockList[i]
                                          .expiry
                                          .toString()
                                          .substring(0, 10),
                                ),
                                Text(
                                  "Stock Amount Left: " +
                                      stockList[i].stockTotal.toString(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Cost: " +
                                    vaccine_map[stockList[i].vaccineCode]!
                                        .cost +
                                    "₹"),
                                ElevatedButton(
                                  onPressed: () async {
                                    DateTime choice = DateTime.now();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return LoaderOverlay(
                                            child: AlertDialog(
                                              title: Text(
                                                  "Choose Your Date of Vaccination"),
                                              content: IconButton(
                                                onPressed: () async {
                                                  DateTime? temp;
                                                  temp = await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate:
                                                          stockList[i].expiry);
                                                  if (temp != null) {
                                                    choice = temp;
                                                    tempdate = choice
                                                        .toString()
                                                        .substring(0, 10);
                                                    tempcode = stockList[i]
                                                        .vaccineCode;
                                                    tempcost = vaccine_map[
                                                            stockList[i]
                                                                .vaccineCode]!
                                                        .cost;
                                                    context.loaderOverlay
                                                        .show();
                                                    await makeMap();
                                                    int value = await getAmount(
                                                        stockList[i].stockId);
                                                    context.loaderOverlay
                                                        .hide();
                                                    if (value <= 0) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "No More Stock Left in this."),
                                                        ),
                                                      );
                                                      setState(() {
                                                        stockList[i]
                                                            .stockTotal = value;
                                                      });
                                                      return;
                                                    }
                                                    setState(() {});
                                                    openCheckout(
                                                        int.parse(vaccine_map[
                                                                    stockList[i]
                                                                        .vaccineCode]!
                                                                .cost) *
                                                            100,
                                                        vaccine_map[stockList[i]
                                                                .vaccineCode]!
                                                            .name);

                                                    Navigator.pop(context);
                                                  }
                                                  ind = i;
                                                },
                                                icon:
                                                    Icon(Icons.calendar_today),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("Book Vaccine"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Profile();
                },
              ),
            );
          },
          child: Icon(Icons.person),
        ),
      ),
    );
  }
}
