import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/payment_request.dart';
import '../model/payment_status.dart';

/// A simple API client for interacting with the Instamojo payment gateway.
///
/// This class handles authentication, creating payment requests,
/// and fetching payment status via the Instamojo REST API.
class InstamojoApi {
  /// Your Instamojo API key (Client ID).
  final String apiKey;

  /// Your Instamojo Auth Token (Client Secret).
  final String authToken;

  /// Creates an instance of [InstamojoApi] with the given credentials.
  InstamojoApi({
    required this.apiKey,
    required this.authToken,
  });

  /// The OAuth access token returned by Instamojo.
  String acesstoken = '';

  /// The base URL for Instamojo API requests.
  String get baseUrl => 'https://api.instamojo.com/';

  /// Fetches an OAuth 2.0 access token from the Instamojo API.
  ///
  /// Returns a valid `access_token` string on success,
  /// or an empty string on failure.
  Future<String> getacesstoken() async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}oauth2/token/'),
        body: {
          'grant_type': 'client_credentials',
          'client_id': apiKey,
          'client_secret': authToken,
        },
      );
      final jsonResponse = json.decode(response.body);
      return jsonResponse['access_token'];
    } catch (e) {
      return '';
    }
  }

  /// Creates a new payment request on Instamojo.
  ///
  /// Takes an [InstamojoPaymentRequest] object containing all
  /// the payment details like `amount`, `purpose`, and `redirect_url`.
  ///
  /// Returns an [InstamojoPaymentResponse] object with the payment
  /// request ID and long URL to redirect users for checkout.
  Future<InstamojoPaymentResponse> createPaymentRequest(
    InstamojoPaymentRequest request,
  ) async {
    try {
      acesstoken = await getacesstoken();
      debugPrint("Request: ${request.toJson()}");

      final response = await http.post(
        Uri.parse('${baseUrl}v2/payment_requests/'),
        headers: {
          'Authorization': 'Bearer $acesstoken',
          'Content-Type':
              'application/x-www-form-urlencoded', // required by Instamojo
        },
        body: request.toJson(),
      );

      final jsonResponse = json.decode(response.body);
      debugPrint("Response from Instamojo: $jsonResponse");

      return InstamojoPaymentResponse.fromJson(jsonResponse);
    } catch (e) {
      return InstamojoPaymentResponse(
        status: 'error',
        error: 'Network error: $e',
      );
    }
  }

  /// Fetches the payment request status from Instamojo servers.
  ///
  /// Takes the [paymentRequestId] obtained from `createPaymentRequest()`
  /// and returns a JSON map with the payment details and status.
  ///
  /// Returns `null` if the status could not be fetched or the request fails.
  Future<Map<String, dynamic>?> getPaymentStatus(
      String paymentRequestId) async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}v2/payment_requests/$paymentRequestId/'),
        headers: {
          'Authorization': 'Bearer $acesstoken',
        },
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error fetching payment status: $e');
    }
    return null;
  }
}
