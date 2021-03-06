import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/custom_route.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/widgets/product_image_popup.dart';
import 'package:git_tees_shop/widgets/quantity_toggle.dart';

class CartListTile extends ConsumerWidget {
  const CartListTile({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isSelected = ref.watch(selectedProvider).contains(product.tshirts.productID);

    Image _productImage =
        productNames.contains(product.tshirts.productName) ? Image.asset('assets/${product.tshirts.productName}.jpeg') : Image.asset('assets/1.jpg');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Checkbox(
            value: _isSelected,
            onChanged: (value) {
              if (_isSelected) {
                ref.read(selectedProvider.notifier).removeFromSelected(product.tshirts.productID);
              } else {
                ref.read(selectedProvider.notifier).addToSelected(product.tshirts.productID);
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CustomRoute(
                    builder: (context) {
                      return ProductImagePopup(
                        productImage: _productImage,
                        heroTag: product.tshirts.productID,
                      );
                    },
                  ),
                );
              },
              child: Hero(
                tag: product.tshirts.productID,
                child: _productImage,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Hero(
            tag: product.tshirts.productID + product.tshirts.productName,
            child: Column(
              children: [
                Text(
                  product.tshirts.productName,
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.tshirts.size,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      product.tshirts.color,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.tshirts.priceStringPHP,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: QuantityToggle(
            product: product,
          ),
        )
      ],
    );
  }
}
