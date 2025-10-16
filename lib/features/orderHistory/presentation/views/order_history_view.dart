import 'package:flutter/material.dart';

import 'package:hungry_app/features/orderHistory/presentation/widgets/custom_again_item.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CustomAgainItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
