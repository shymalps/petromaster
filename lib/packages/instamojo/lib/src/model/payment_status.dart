class InstamojoPaymentResponse {
  final String? paymentRequestId;
  final String? longurl;
  final String? shorturl;
  final String? status;
  final String? error;

  InstamojoPaymentResponse({
    this.paymentRequestId,
    this.longurl,
    this.shorturl,
    this.status,
    this.error,
  });

  factory InstamojoPaymentResponse.fromJson(Map<String, dynamic> json) {
    return InstamojoPaymentResponse(
      paymentRequestId: json['id'] as String?,
      longurl: json['longurl'] as String?,
      shorturl: json['shorturl'] as String?,
      status: json['status'] as String?, // Pending, Completed, Failed, etc.
      error: (() {
        final phone = json['phone'];
        final email = json['email'];

        String? getValue(dynamic value) {
          if (value is String) return value;
          if (value is List && value.isNotEmpty) return value.first as String;
          return null;
        }

        return getValue(phone) ?? getValue(email);
      })(),
    );
  }
}
