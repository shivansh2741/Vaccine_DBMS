import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vaccination_dbms/main.dart';
import 'package:vaccination_dbms/model/stock.dart';
import 'package:vaccination_dbms/model/vaccine.dart';

Future<void> makeMap() async {
  var url = Uri.parse('https://gautam131714.000webhostapp.com/getvaccine.php');
  var response = await http.get(url);
  if (response.body == "") {
    return;
  }
  var details = jsonDecode(response.body);

  for (int i = 0; i < details.length; i++) {
    Vaccine temp = Vaccine(
      code: details[i]['code'],
      cost: details[i]['cost'],
      efficacy: details[i]['efficacy'],
      name: details[i]['name'],
    );
    vaccine_map[details[i]['code']] = temp;
  }
}

Future<int> getAmount(String id) async {
  var url = Uri.parse('https://gautam131714.000webhostapp.com/getstock.php');
  var response = await http.get(url);
  var details = jsonDecode(response.body);
  for (int i = 0; i < details.length; i++) {
    Stock temp = Stock(
        expiry: DateTime.parse(details[i]['expiry_date']),
        stockId: details[i]['stock_id'],
        stockTotal: int.parse(details[i]['stock_total']),
        vaccineCode: details[i]['vaccine_code']);
    if (temp.stockId == id) {
      return temp.stockTotal;
    }
  }
  return -1;
}

Future<void> makeStockList() async {
  var url = Uri.parse('https://gautam131714.000webhostapp.com/getstock.php');
  var response = await http.get(url);
  if (response.body == "") {
    return;
  }
  var details = jsonDecode(response.body);
  stockList.clear();
  for (int i = 0; i < details.length; i++) {
    Stock temp = Stock(
        expiry: DateTime.parse(details[i]['expiry_date']),
        stockId: details[i]['stock_id'],
        stockTotal: int.parse(details[i]['stock_total']),
        vaccineCode: details[i]['vaccine_code']);
    if (temp.stockTotal > 0) {
      stockList.add(temp);
    }
  }
}

Future<String> login(String email, String password) async {
  var url = Uri.parse('https://gautam131714.000webhostapp.com/getlogin.php');
  var response = await http.get(url);
  if (response.body == "") {
    return "No User with that email";
  }
  var details = jsonDecode(response.body);
  int flag = 0;
  for (int i = 0; i < details.length; i++) {
    if (details[i]['email'] == email) {
      if (details[i]['password'] == password) {
        flag = 2;
        break;
      } else {
        flag = 1;
        break;
      }
    }
  }
  if (flag == 2) {
    return "True";
  } else if (flag == 1) {
    return "Incorrect Password";
  } else {
    return "No User with that email";
  }
}

Future<String> register(String email, String password, String username) async {
  if (email == "" || password == "" || username == "") {
    return "Please Fill All The Fields";
  }
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) {
    return "Enter Valid Email";
  }
  if (password.length < 6) {
    return "Password Should be atleast 6 Characters";
  }
  var urll = Uri.parse('https://gautam131714.000webhostapp.com/getlogin.php');
  var response = await http.get(urll);
  if (response.body != "") {
    var details = jsonDecode(response.body);
    for (int i = 0; i < details.length; i++) {
      if (details[i]['email'] == email) {
        return "User with that email already exists";
      }
    }
  }

  Map<String, String> m = {
    "email": email,
    "password": password,
    "username": username
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/adduser.php');
  await http.post(url, body: m);
  return "True";
}

Future<String> checkPower(String email) async {
  var urll = Uri.parse('https://gautam131714.000webhostapp.com/checkadmin.php');
  var response = await http.get(urll);
  if (response.body != "") {
    var details = jsonDecode(response.body);
    for (int i = 0; i < details.length; i++) {
      if (details[i]['email'] == email) {
        return "Admin";
      }
    }
  }
  var url = Uri.parse('https://gautam131714.000webhostapp.com/checkstaff.php');
  response = await http.get(url);
  if (response.body != "") {
    var detailss = jsonDecode(response.body);
    for (int i = 0; i < detailss.length; i++) {
      if (detailss[i]['email'] == email) {
        return "Staff";
      }
    }
  }
  return "";
}

Future<String> addVaccine(
    String code, String name, String efficacy, String cost) async {
  if (code == '' || name == "" || efficacy == "" || cost == "") {
    return "Fill All the Fields";
  }
  var urll = Uri.parse('https://gautam131714.000webhostapp.com/getvaccine.php');
  var response = await http.get(urll);
  if (response.body != "") {
    var details = jsonDecode(response.body);
    for (int i = 0; i < details.length; i++) {
      if (details[i]['code'] == code) {
        return "Vaccine With This Code already Exists";
      }
    }
  }
  Map<String, String> m = {
    "code": code,
    "name": name,
    "cost": cost,
    "efficacy": efficacy,
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/addvaccine.php');
  await http.post(url, body: m);
  return "True";
}

Future<String> addStock(
    String stock_id, String code, String amount, String expiry) async {
  if (stock_id == "" || code == "" || amount == "" || expiry == "") {
    return "Fill All The Fields";
  }
  var urll = Uri.parse('https://gautam131714.000webhostapp.com/getstock.php');
  var response = await http.get(urll);
  if (response.body != "") {
    var details = jsonDecode(response.body);
    for (int i = 0; i < details.length; i++) {
      if (details[i]['stock_id'] == stock_id) {
        return "Stock With This ID already Exists";
      }
    }
  }
  var urlll =
      Uri.parse('https://gautam131714.000webhostapp.com/getvaccine.php');
  var responsee = await http.get(urlll);
  bool cond = true;
  if (response.body != "") {
    var detaills = jsonDecode(responsee.body);
    for (int i = 0; i < detaills.length; i++) {
      if (detaills[i]['code'] == code) {
        cond = false;
        break;
      }
    }
  }
  if (cond) {
    return "No Vaccine With This Code Exists";
  }
  Map<String, String> m = {
    "stock_id": stock_id,
    "vaccine_code": code,
    "stock_total": amount,
    "expiry_date": expiry,
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/addstock.php');
  await http.post(url, body: m);
  return "True";
}

Future<void> editPrice(String cost, String code) async {
  Map<String, String> m = {'cost': cost, 'code': code};
  var url = Uri.parse('https://gautam131714.000webhostapp.com/editprice.php');
  await http.post(url, body: m);
  await makeMap();
}

Future<void> addPaymentRecord(
    String id, String email, String code, String amount, String date) async {
  Map<String, String> m = {
    'amount': amount,
    'email': email,
    'code': code,
    'id': id,
    'date': date,
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/addPayment.php');
  await http.post(url, body: m);
}

Future<void> addAdmin(String email) async {
  Map<String, String> m = {
    'email': email,
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/addAdmin.php');
  await http.post(url, body: m);
}

Future<void> addStaff(String email) async {
  Map<String, String> m = {
    'email': email,
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/addStaff.php');
  await http.post(url, body: m);
}

Future<void> editStockAmount(String amount, String id) async {
  Map<String, String> m = {'id': id, 'amount': amount};
  var url =
      Uri.parse('https://gautam131714.000webhostapp.com/editStockAmount.php');
  var resp = await http.post(url, body: m);
}
