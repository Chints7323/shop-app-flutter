import 'package:flutter/material.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/widgets/product_gride.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/provider/products_provider.dart';

enum Filteroptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFactorites = false;
  var _isInIt = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInIt) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProduct().then(
            (_) => setState(() {
              _isLoading = false;
            }),
          );
    }
    _isInIt = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (Filteroptions selectedValue) {
              setState(() {
                if (selectedValue == Filteroptions.Favorites) {
                  _showOnlyFactorites = true;
                } else {
                  _showOnlyFactorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: Filteroptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: Filteroptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGride(_showOnlyFactorites),
    );
  }
}
