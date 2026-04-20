class InstamojoPaymentRequest {
  final String purpose;
  final double amount;
  final String buyerName;
  final String email;
  final String phone;
  final String redirectUrl;
  // final dynamic sendEmail;
  // final dynamic sendSms;
  // final dynamic allowRepeatedPayments;

  InstamojoPaymentRequest({
    required this.purpose,
    required this.amount,
    required this.buyerName,
    required this.email,
    required this.phone,
    required this.redirectUrl,
    // this.sendEmail = true,
    // this.sendSms = true,
    // this.allowRepeatedPayments = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'purpose': purpose,
      'amount': amount.toString(),
      'buyer_name': buyerName,
      'email': email,
      'phone': phone,
      'redirect_url': redirectUrl,
      // 'send_email': sendEmail,
      // 'send_sms': sendSms,
      // 'allow_repeated_payments': allowRepeatedPayments,
    };
  }
}
