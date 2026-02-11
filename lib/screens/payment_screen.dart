import 'package:flutter/material.dart';

import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final int ticketCount;

  const PaymentMethodScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.ticketCount,
  });

  @override
  State<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'cod';
  bool _isLoading = false;

  // Ticket price
  final double ticketPrice = 200.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final totalAmount = widget.ticketCount * ticketPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Booking Summary
            _buildSummaryCard(totalAmount),

            const SizedBox(height: 20),

            Text(
              'Choose Payment Method',
              style: textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            _paymentTile(
              value: 'cod',
              title: 'Cash on Delivery',
              subtitle: 'Pay at venue',
              icon: Icons.money,
            ),

            _paymentTile(
              value: 'online',
              title: 'Online Payment',
              subtitle: 'Card / bKash / Nagad',
              icon: Icons.credit_card,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _onConfirmPayment,
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text('Confirm Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Summary =================

  Widget _buildSummaryCard(double totalAmount) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Booking Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const Divider(),

            _summaryRow("Name", widget.name),
            _summaryRow("Email", widget.email),
            _summaryRow("Phone", widget.phone),
            _summaryRow("Tickets", widget.ticketCount.toString()),
            _summaryRow(
              "Total",
              "৳ ${totalAmount.toStringAsFixed(2)}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Payment Tile

  Widget _paymentTile({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() => _selectedMethod = value!);
        },
        title: Text(title),
        subtitle: Text(subtitle),
        secondary: Icon(icon, color: Colors.blueGrey),
      ),
    );
  }

  //  Confirm

  void _onConfirmPayment() {
    if (_selectedMethod == 'cod') {
      _placeCodOrder();
    } else {
      _startSSLCommerzTransaction();
    }
  }

  void _placeCodOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully (COD)'),
      ),
    );

    Navigator.pop(context);
  }

  // SSLCommerz

  Future<void> _startSSLCommerzTransaction() async {
    setState(() => _isLoading = true);

    final totalAmount = widget.ticketCount * 200.0;

    final sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        store_id: "demotest", // Change in LIVE
        store_passwd: "qwerty", // Change in LIVE
        currency: SSLCurrencyType.BDT,
        tran_id: DateTime.now().millisecondsSinceEpoch.toString(),
        product_category: "Ticket",
        sdkType: SSLCSdkType.TESTBOX,

        // Required
        total_amount: totalAmount,
      ),
    );

    try {
      SSLCTransactionInfoModel result =
      await sslcommerz.payNow();

      _handlePaymentResult(result);
    } catch (e) {
      _showError('Payment failed: $e');
    }

    setState(() => _isLoading = false);
  }

  // ================= Result =================
  void _handlePaymentResult(SSLCTransactionInfoModel result) {
    print("STATUS: ${result.status}");
    print("AMOUNT: ${result.amount}");
    print("TRANSACTION ID: ${result.tranId}");

    if (result.status == 'VALID') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment Successful')),
      );
      Navigator.pop(context);
    } else {
      _showError('Payment Failed (Status: ${result.status})');
    }
  }


  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
