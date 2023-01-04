class Stock {
  late String stockId, vaccineCode;
  late int stockTotal;
  late DateTime expiry;
  Stock(
      {required this.expiry,
      required this.stockId,
      required this.stockTotal,
      required this.vaccineCode});
}
