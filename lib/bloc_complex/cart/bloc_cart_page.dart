import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_complex/cart/cart_provider.dart';
import 'package:gank_flutter_app/bloc_complex/models/cart_item.dart';

class BlocCartPage extends StatelessWidget {
  BlocCartPage();

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: cart.items,
          builder: (context, snapshot) {
            if (snapshot.data?.isEmpty ?? true) {
              return Center(
                  child: Text('Empty',
                      style: Theme.of(context).textTheme.display1));
            }

            return ListView(
                children:
                    snapshot.data.map((item) => ItemTile(item: item)).toList());
          }),
    );
  }
}
