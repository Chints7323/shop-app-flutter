import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:shop_app/provider/products_provider.dart';
import 'package:provider/provider.dart';
//import '../model/product.dart';

class ProductGride extends StatelessWidget {
  final bool showFavs;
  ProductGride(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (c) => products[i] ,
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            // products[i].price,
            ),
      ),
      itemCount: products.length,
    );
  }
}
