import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vaccination_dbms/func.dart';
import 'package:vaccination_dbms/main.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  bool cond = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  Future<void> getList() async {
    await makeStockList();
    setState(() {
      cond = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StaffHomePage"),
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
                style: OutlinedButton.styleFrom(
                  onSurface: Colors.blue,
                ),
                onPressed: () async {
                  String code = "", name = "", efficacy = "", cost = "";
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Add a New Vaccine"),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  initialValue: "",
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    label: Text("Name"),
                                    hintText: "Name",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    code = value;
                                  },
                                  initialValue: "",
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    label: Text("Vaccine Code"),
                                    hintText: "Vaccine Code",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    efficacy = value;
                                  },
                                  initialValue: "",
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    label: Text("Efficacy"),
                                    hintText: "Efficacy",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    cost = value;
                                  },
                                  initialValue: "",
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text("Cost"),
                                    hintText: "Cost",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  String result = await addVaccine(
                                      code, name, efficacy, cost);
                                  if (result != 'True') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result),
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("Insert"),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text("Add Vaccine"),
              ),
              ElevatedButton(
                onPressed: () async {
                  String code = "", stock_id = "", amount = "";
                  DateTime expiry = DateTime.now();
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      context: context,
                      builder: (BuildContext context) {
                        return LoaderOverlay(
                          child: StatefulBuilder(
                              builder: (BuildContext context, ss) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("Add a New Stock"),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        stock_id = value;
                                      },
                                      initialValue: "",
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        label: Text("Stock ID"),
                                        hintText: "Stock ID",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        code = value;
                                      },
                                      initialValue: "",
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        label: Text("Vaccine Code"),
                                        hintText: "Vaccine Code",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        amount = value;
                                      },
                                      initialValue: "",
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        label: Text("Amount of Vaccine"),
                                        hintText: "Amount of Vaccine",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    title: const Text("Expiry Date:"),
                                    subtitle: Text(
                                      expiry.toString().substring(0, 10),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        DateTime? val = await showDatePicker(
                                          context: context,
                                          initialDate: expiry,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2025),
                                        );
                                        if (val != null) {
                                          ss(() {
                                            expiry = val;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      context.loaderOverlay.show();
                                      String result = await addStock(
                                        stock_id,
                                        code,
                                        amount,
                                        expiry.toString().substring(0, 10),
                                      );
                                      if (result != 'True') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result),
                                          ),
                                        );
                                      } else {
                                        await makeMap();
                                        await getList();
                                      }
                                      context.loaderOverlay.hide();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Insert"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      });
                },
                child: const Text("Add Stock"),
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
