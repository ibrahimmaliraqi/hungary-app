import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SwuftPayView extends StatefulWidget {
  final String orderId;
  final String title;
  final int amount;
  final String customerName;
  final String customerPhone;

  const SwuftPayView({
    super.key,
    required this.orderId,
    required this.title,
    required this.amount,
    required this.customerName,
    required this.customerPhone,
  });

  @override
  State<SwuftPayView> createState() => _SwuftPayViewState();
}

class _SwuftPayViewState extends State<SwuftPayView> {
  bool isLoading = false;

  Future<void> createPayment() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'create-payment-link',
        body: {
          'orderId': widget.orderId,
          'title': widget.title,
          'amount': widget.amount.toString(),
          'customerName': widget.customerName,
          'customerPhone': widget.customerPhone,
        },
      );

      final data = response.data;

      if (data == null || data['success'] != true) {
        throw Exception(
          data?['message'] ?? 'فشل إنشاء رابط الدفع',
        );
      }

      final String payPageUrl = data['payPageUrl'];

      final Uri uri = Uri.parse(payPageUrl);

      if (!await canLaunchUrl(uri)) {
        throw Exception('لا يمكن فتح صفحة الدفع');
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } on FunctionException catch (e) {
      _showMessage(
        e.details?.toString() ?? 'حدث خطأ أثناء إنشاء عملية الدفع',
      );
    } catch (e) {
      _showMessage(
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Text(
              '${widget.amount} د.ع',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

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
                      'الدفع الآن',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
