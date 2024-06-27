import 'package:flutter/material.dart';
import 'product_item_widget.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    this.isInHome = false,
  });
  final bool isInHome;
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: isInHome
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1 / 1.4,
      children: List.generate(
        products.length,
        (index) => ProductItemWidget(
          product: products[index],
        ),
      ),
    );
  }
}
