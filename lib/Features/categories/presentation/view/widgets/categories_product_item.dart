import 'package:flutter/material.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../category_products_screen.dart';

class CategoriesProductItem extends StatelessWidget {
  const CategoriesProductItem({
    super.key,
    required this.categoryModel,
  });
  final dynamic categoryModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryProductsScreen(categoryModel: categoryModel),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: size.width * .3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: size.width * .25,
                color: Colors.white,
                child: AspectRatio(
                  aspectRatio: 1 / .9,
                  child: CustomNetworkImage(
                      imageUrl: categoryModel?.image.toString() ?? nullImage),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoryModel?.name.toString() ?? 'Name',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                            categoryModel: categoryModel),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
