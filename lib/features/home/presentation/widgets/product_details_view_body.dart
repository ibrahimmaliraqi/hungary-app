import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/widgets/custom_text.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/presentation/manager/get_product_options/get_product_options_cubit.dart';
import 'package:hungry_app/features/home/presentation/widgets/size_options_bloc.dart';
import 'package:hungry_app/features/home/presentation/widgets/spicy_slider.dart';
import 'package:hungry_app/features/home/presentation/widgets/toppins_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsViewBody extends StatefulWidget {
  final ProductEntity productEntity;
  const ProductDetailsViewBody({super.key, required this.productEntity});

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  @override
  void initState() {
    context.read<GetProductOptionsCubit>().getProductOptions(
      productId: widget.productEntity.id,
    );
    super.initState();
  }

  double value = 0.5;
  List<int> selectedTopping = [];
  List<int> selectedSideOption = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpicySlider(
              image: widget.productEntity.image,
              value: value,
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
            Gap(40),
            CustomText(
              text: "الإضافات",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Gap(9),
            ToppingsListBloc(),
            Gap(40),
            CustomText(
              text: "الخيارات الجانبية",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Gap(9),
            SizeOptionListBloc(),

            Gap(110),
          ],
        ),
      ),
    );
  }
}
