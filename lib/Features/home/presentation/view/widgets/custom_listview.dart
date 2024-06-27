import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/consts.dart';
import '../../../../categories/data/models/category_model/datum.dart';
import '../../../../categories/presentation/view/category_products_screen.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.categoriesList,
  });
  final List<CategoryDataListModel> categoriesList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          height: size.width * .2,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsScreen(
                          categoryModel: categoriesList[index]),
                    ),
                  );
                },
                child: Stack(
                  alignment: index == 0
                      ? AlignmentDirectional.bottomEnd
                      : AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      margin: EdgeInsets.only(
                        left: index == 0 ? 10 : 0,
                        right: index == 4 ? 10 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: size.width * .2,
                        width: size.width * .25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                categoriesList[index].image ?? nullImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .253,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColorDark.withOpacity(.8),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        categoriesList[index].name.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
