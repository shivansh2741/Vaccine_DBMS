import 'package:flutter/material.dart';
import 'package:vaccination_dbms/func.dart';
import 'package:vaccination_dbms/main.dart';

class AdminVaccine extends StatefulWidget {
  const AdminVaccine({Key? key}) : super(key: key);

  @override
  State<AdminVaccine> createState() => _AdminVaccineState();
}

class _AdminVaccineState extends State<AdminVaccine> {
  List<String> codes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i in vaccine_map.values) {
      codes.add(i.code);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccine List"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: ListView.builder(
            itemCount: codes.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(vaccine_map[codes[i]]!.name),
                  subtitle: Text(vaccine_map[codes[i]]!.cost + "₹"),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            String newprice = "";
                            return AlertDialog(
                              title: Text("Edit Price"),
                              content: TextField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Price",
                                ),
                                onChanged: (value) {
                                  newprice = value;
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await editPrice(newprice, codes[i]);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text("Set New Price"),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
