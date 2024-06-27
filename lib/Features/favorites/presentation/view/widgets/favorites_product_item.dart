import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../../core/widgets/custom_network_image.dart';
import '../../../../../core/widgets/price_widget.dart';
import '../../../../home/presentation/view/widgets/like_and_add_item_icon.dart';
import '../../../data/models/favorite_model/favorite_product_model.dart';

class FavoritesProductItem extends StatelessWidget {
  const FavoritesProductItem({
    super.key,
    required this.favoriteProduct,
  });
  final FavoriteProductModel? favoriteProduct;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: size.width * .3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: size.width * .25,
                color: Colors.white,
                child: AspectRatio(
                  aspectRatio: 1 / .9,
                  child: ConditionalBuilder(
                    condition: favoriteProduct?.discount != 0,
                    builder: (context) => Banner(
                      message: 'Discount',
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      location: BannerLocation.topEnd,
                      child: CustomNetworkImage(
                          imageUrl:
                              favoriteProduct?.image.toString() ?? nullImage),
                    ),
                    fallback: (context) => CustomNetworkImage(
                        imageUrl:
                            favoriteProduct?.image.toString() ?? nullImage),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favoriteProduct?.name.toString() ?? 'Name',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  PriceWidget(
                    price: favoriteProduct?.price ?? 0,
                    color: Colors.green,
                  ),
                  if (favoriteProduct?.discount != 0)
                    Row(
                      children: [
                        Text(
                          '- ${favoriteProduct?.discount}% ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.red.shade400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EGP',
                              style: Theme.of(context).textTheme.labelSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${favoriteProduct?.oldPrice ?? ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.grey,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: LikeAndAddItemIcon(
                      inFav: true,
                      product: favoriteProduct,
                    ),
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
