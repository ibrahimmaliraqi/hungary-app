import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WaylPaymentPage extends StatefulWidget {
  const WaylPaymentPage({
    super.key,
  });

  @override
  State<WaylPaymentPage> createState() => _WaylPaymentPageState();
}

class _WaylPaymentPageState extends State<WaylPaymentPage> {
  bool isLoading = false;

  String? referenceId;

  String? paymentStatus;

  Future<void> createPayment() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'create-wayl-payment',
        body: {
          'amount': 10000,

          'customerName': 'ابراهيم علي',

          'customerPhone': '964770543214',
        },
      );

      final data = response.data;

      debugPrint(
        'Wayl response: $data',
      );

      if (data == null || data['success'] != true) {
        throw Exception(
          data?['message'] ?? 'Failed to create payment',
        );
      }

      final checkoutUrl = data['checkoutUrl'];

      referenceId = data['referenceId'];

      paymentStatus = data['status'];

      debugPrint(
        'Reference ID: $referenceId',
      );

      debugPrint(
        'Checkout URL: $checkoutUrl',
      );

      if (checkoutUrl == null || checkoutUrl.toString().isEmpty) {
        throw Exception(
          'Checkout URL is missing',
        );
      }

      // -----------------------------------------
      // Open Wayl
      // -----------------------------------------

      final uri = Uri.parse(
        checkoutUrl.toString(),
      );

      final canOpen = await canLaunchUrl(uri);

      if (!canOpen) {
        throw Exception(
          'Could not open payment URL',
        );
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء عملية الدفع',
          ),
        ),
      );
    } catch (e) {
      debugPrint(
        'Payment error: $e',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'حدث خطأ: $e',
          ),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الدفع',
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            if (referenceId != null)
              Text(
                'Reference: $referenceId',
              ),

            const SizedBox(
              height: 20,
            ),

            if (paymentStatus != null)
              Text(
                'Status: $paymentStatus',
              ),

            const SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: isLoading ? null : createPayment,

              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'ادفع 10,000 د.ع',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
