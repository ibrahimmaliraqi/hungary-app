import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/presentation/manager/products_by_title/products_by_title_cubit.dart';

class HomeSearch extends StatelessWidget {
  final bool? isEnabled;
  const HomeSearch({super.key, this.isEnabled = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        onChanged: (value) {
          if (!value.isEmpty) {
            context.read<ProductsByTitleCubit>().getProductsByTitle(
              query: value,
            );
          } else {
            context.read<ProductsByTitleCubit>().stopSearch();
          }
        },
        enabled: isEnabled,

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Colors.black,
          ),
          hintText: "ابحث عن طعامك",

          hintStyle: TextStyle(color: Colors.black),
          border: buildBorder(),
          disabledBorder: buildBorder(),
          enabledBorder: buildBorder(),
          errorBorder: buildBorder(),
          focusedBorder: buildBorder(),
          focusedErrorBorder: buildBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    );
  }
}
