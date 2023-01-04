class Payment {
  late String payment_id, email, amount, vaccine_code;
  late DateTime date;
  Payment({
    required this.amount,
    required this.email,
    required this.payment_id,
    required this.vaccine_code,
    required this.date,
  });
}
