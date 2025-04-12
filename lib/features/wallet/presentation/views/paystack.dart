import 'package:flutter/material.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatefulWidget {
  const PaymentWebViewPage(
      {super.key,
      required this.amount,
      required this.refrence,
      required this.email,
      required this.paystackPublicKey,
      required this.successUrl});
  final String amount;
  final String refrence;
  final String email;
  final String paystackPublicKey;
  final String successUrl;
  @override
  _PaymentWebViewPageState createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;
  // Define the success URL that your Paystack callback uses.

  @override
  void initState() {
    super.initState();
    // Instantiate and configure the WebViewController.
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // When the URL starts with the successUrl, pop the WebView.
            if (request.url.startsWith(widget.successUrl)) {
              Navigator.pop(context, 'success');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            // Optionally, handle when a page starts loading.
          },
          onPageFinished: (String url) {
            // Optionally, handle when a page finishes loading.
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors here.
          },
        ),
      )
      ..loadRequest(Uri.parse(_buildPaymentUrl()));
  }

  /// Constructs the Paystack checkout URL with required parameters.
  /// Replace the placeholder values with your actual configuration.
  String _buildPaymentUrl() {
    // Replace with your actual Paystack public key.
    final String paystackPublicKey = widget.paystackPublicKey;
    // Generate a unique reference for this transaction.
    final String reference = widget.refrence;
    // Define the callback URL (must match your Paystack settings).
    final String callbackUrl = widget.successUrl;

    // Construct the URL.
    final Uri uri = Uri.https("checkout.paystack.com", "/$reference", {
      "key": paystackPublicKey,
      "email": widget.email,
      "amount": widget.amount, // Amount in kobo (e.g., ₦10.00 if using NGN)
      "callback_url": callbackUrl,
    });
    print("URI: ${uri.toString()}");
    return uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        title: const Text('Complete Payment'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
