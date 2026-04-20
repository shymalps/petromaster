import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api/instamojo_api.dart';
import '../model/payment_request.dart';

/// A screen widget that handles Instamojo payment flow using WebView.
///
/// The [PaymentScreen] automatically creates a payment request using the
/// Instamojo API, opens the payment URL, and listens for completion or cancellation.
///
/// Example:
/// ```dart
/// PaymentScreen(
///   clientId: 'your_client_id',
///   clientsecret: 'your_client_secret',
///   paymentRequest: InstamojoPaymentRequest(...),
///   onPaymentSuccess: (response) => print('Success: $response'),
///   onPaymentError: (error) => print('Error: $error'),
///   onPaymentCancel: () => print('Cancelled'),
/// );
/// ```
class PaymentScreen extends StatefulWidget {
  /// Your Instamojo client ID.
  final String clientId;

  /// Your Instamojo client secret.
  final String clientsecret;

  /// The payment request model containing payment details.
  final InstamojoPaymentRequest paymentRequest;

  /// Callback triggered when the payment is successful.
  final Function(Map<String, dynamic>) onPaymentSuccess;

  /// Callback triggered when there is a payment error.
  final Function(String) onPaymentError;

  /// Callback triggered when the user cancels the payment manually.
  final Function()? onPaymentCancel;

  /// Creates a [PaymentScreen] widget.
  const PaymentScreen(
      {super.key,
      required this.clientId,
      required this.clientsecret,
      required this.paymentRequest,
      required this.onPaymentSuccess,
      required this.onPaymentError,
      this.onPaymentCancel});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

/// Internal state for the [PaymentScreen].
class _PaymentScreenState extends State<PaymentScreen> {
  /// Instance of [InstamojoApi] service used for API calls.
  late InstamojoApi _service;

  /// Indicates whether the payment initialization or verification is in progress.
  bool _isLoading = false;

  /// Holds error messages if any occur during the process.
  String? _error;

  /// URL of the Instamojo payment page.
  String? _paymentUrl;
  // String? _paymentRequestId;

  /// Controller for managing WebView behavior.
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _service = InstamojoApi(
      apiKey: widget.clientId,
      authToken: widget.clientsecret,
    );
    _initializePayment();
  }

  /// Initializes the payment by creating a payment request and loading its URL.
  Future<void> _initializePayment() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response =
          await _service.createPaymentRequest(widget.paymentRequest);
      // consolePrint(response['access_token']);
      debugPrint(response.status ?? 'empty status');
      debugPrint(response.longurl ?? 'empty longurl');

      if (response.status == 'Pending' && response.longurl != null) {
        setState(() {
          _paymentUrl = response.longurl;
          // _paymentRequestId = response.paymentRequestId;
          _isLoading = false;
        });
        _setupWebViewController();
      } else {
        setState(() {
          _error = response.error ?? 'Failed to create payment request';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  /// Configures the WebView controller for handling navigation events and UPI intents.
  void _setupWebViewController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            // Make this async
            debugPrint('Navigation to: ${request.url}');

            // Check for UPI intent URLs first
            if (_isUpiIntent(request.url)) {
              debugPrint('UPI Intent detected: ${request.url}');
              await _handleUpiIntent(request.url);
              return NavigationDecision.prevent;
            }

            // Check if it's the redirect URL (payment completion)
            if (request.url.startsWith(widget.paymentRequest.redirectUrl)) {
              _handlePaymentCompletion(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(_paymentUrl!));
  }

  /// Launches an external UPI app when a UPI payment intent is detected.
  Future<void> _handleUpiIntent(String url) async {
    try {
      Uri uri;

      // Handle Android intent URLs
      if (url.startsWith('intent://')) {
        // Extract the UPI URL from Android intent format
        final upiMatch = RegExp(r'intent://(.+?)#Intent').firstMatch(url);
        if (upiMatch != null) {
          uri = Uri.parse('upi://${upiMatch.group(1)}');
        } else {
          throw Exception('Invalid intent URL format');
        }
      } else {
        uri = Uri.parse(url);
      }

      debugPrint('Attempting to launch UPI app with: $uri');

      // Try to launch the UPI app
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        debugPrint('Failed to launch UPI app');
        // Show a user-friendly message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('No UPI app found. Please install a UPI payment app.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error launching UPI app: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Unable to open payment app. Please try another payment method.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Determines whether the given URL corresponds to a UPI intent or payment link.
  bool _isUpiIntent(String url) {
    return url.startsWith('intent://') && url.contains('scheme=upi') ||
        url.startsWith('upi://') ||
        url.startsWith('tez://') ||
        url.startsWith('gpay://') ||
        url.startsWith('phonepe://') ||
        url.startsWith('paytmmp://') ||
        url.startsWith('bhim://') ||
        url.startsWith('mobikwik://');
  }

  /// Handles payment completion by verifying the payment status from Instamojo.
  Future<void> _handlePaymentCompletion(String url) async {
    debugPrint('Payment completion URL: $url');

    // Parse URL parameters
    final uri = Uri.parse(url);
    final paymentId = uri.queryParameters['payment_id'];
    final paymentRequestId = uri.queryParameters['payment_request_id'];
    // final status = uri.queryParameters['payment_status'];

    debugPrint(
        'Payment ID: $paymentId, Payment Request ID: $paymentRequestId url is $url');

    if (paymentId != null && paymentRequestId != null) {
      // Show loading while verifying
      setState(() {
        _isLoading = true;
      });

      // Verify payment status from server
      try {
        final paymentStatus = await _service.getPaymentStatus(paymentRequestId);

        if (paymentStatus != null && paymentStatus['status'] == 'Completed') {
          debugPrint('Payment status verified: $paymentStatus');
          var response = {
            'MojId': paymentId,
            'paymentRequestId': paymentRequestId,
            'amount': paymentStatus['amount'],
            'name': paymentStatus['buyer_name'],
            'payment_details': paymentStatus,
          };
          widget.onPaymentSuccess(response);
        } else {
          widget.onPaymentError('Failed to verify payment status');
        }
      } catch (e) {
        debugPrint('Error verifying payment: $e');
        widget.onPaymentError('Error verifying payment: $e');
      }
    } else {
      widget.onPaymentError('Payment was not completed successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // similar to returning true from onWillPop
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) return;
        if (widget.onPaymentCancel != null) {
          widget.onPaymentCancel!();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              if (widget.onPaymentCancel != null) {
                widget.onPaymentCancel!();
              }
            },
          ),
          centerTitle: true,
          title: const Text(
            'Payment',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  /// Builds the UI body based on the payment state.
  Widget _buildBody() {
    if (_isLoading) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Initializing payment...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait a moment',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Payment Error',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.shade100,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _initializePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_paymentUrl != null) {
      return WebViewWidget(controller: _webViewController);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade100,
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
