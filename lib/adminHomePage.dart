import 'package:flutter/material.dart';
import 'package:vaccination_dbms/adminVaccines.dart';
import 'package:vaccination_dbms/func.dart';
import 'package:vaccination_dbms/main.dart';
import 'package:vaccination_dbms/paymentList.dart';

List<Widget> pages = [
  AdminHomePage(),
  AdminVaccine(),
  PaymentList(),
];

class AdminMain extends StatefulWidget {
  const AdminMain({Key? key}) : super(key: key);

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[ind],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            ind = val;
          });
        },
        currentIndex: ind,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Vaccines",
            icon: Icon(Icons.vaccines),
          ),
          BottomNavigationBarItem(
            label: "Payment",
            icon: Icon(Icons.money),
          ),
        ],
      ),
    );
  }
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool cond = true;
  @override
  void initState() {
    super.initState();
    makeList();
  }

  Future<void> makeList() async {
    await makeStockList();
    cond = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdminHomePage"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        String newmail = "";
                        return AlertDialog(
                          title: const Text(
                              "Enter The email to be granted admin Rights"),
                          content: TextField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintStyle: const TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                            ),
                            onChanged: (value) {
                              newmail = value;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await addAdmin(newmail);
                                Navigator.pop(context);
                              },
                              child: const Text("Add Admin"),
                            ),
                          ],
                        );
                      });
                },
                child: const Text("Add Admin"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        String newmail = "";
                        return AlertDialog(
                          title: const Text(
                              "Enter The email to be granted Staff Rights"),
                          content: TextField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintStyle: const TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                            ),
                            onChanged: (value) {
                              newmail = value;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await addStaff(newmail);
                                Navigator.pop(context);
                              },
                              child: const Text("Add Staff"),
                            ),
                          ],
                        );
                      });
                },
                child: const Text("Add Staff"),
              ),
            ],
          ),
          if (cond) const CircularProgressIndicator(),
          Flexible(
            child: ListView.builder(
              itemCount: stockList.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    title: Text(vaccine_map[stockList[i].vaccineCode]!.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Efficacy: " +
                            vaccine_map[stockList[i].vaccineCode]!.efficacy +
                            "%"),
                        Text(
                          "Stock Amount Left: " +
                              stockList[i].stockTotal.toString(),
                        ),
                      ],
                    ),
                    leading: const Icon(Icons.vaccines),
                    trailing:
                        Text(vaccine_map[stockList[i].vaccineCode]!.cost + "₹"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
