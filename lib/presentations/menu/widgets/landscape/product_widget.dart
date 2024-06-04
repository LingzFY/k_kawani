// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/data/bloc/product_bloc/product_bloc.dart';
import 'package:k_kawani/data/models/product_model.dart';
import 'package:k_kawani/data/models/transaction_item_model.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class ProductWidgetLandscape extends StatelessWidget {
  const ProductWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status.isOk) {
            return FlexibleGridView(
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              axisCount: GridLayoutEnum.fourElementsInRow,
              physics: const BouncingScrollPhysics(),
              children: [
                for (int i = 0; i < state.products.Items.length; i++)
                  ProductItemWidget(
                    product: state.products.Items[i],
                    callback: (ProductModel productModel) {
                      context.read<TransactionBloc>().add(
                            AddTransactionItemList(
                              transactionItemModel: TransactionItemModel(
                                Id: productModel.Id,
                                idItem: productModel.Id,
                                Qty: 1,
                                Product: productModel,
                                Notes: '',
                                Description: '',
                              ),
                            ),
                          );
                    },
                  ),
              ],
            );
          }
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              crossAxisCount: 4,
              childAspectRatio: 1 / 1,
            ),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (int i = 0; i < 8; i++)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0)),
                )
            ],
          );
        },
      ),
    );
  }
}

typedef ProductCLicked = Function(ProductModel productSelected);

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget(
      {super.key, required this.product, required this.callback});

  final ProductCLicked callback;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(product),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _LoadImage(
                  key: ValueKey(product.Id!),
                  ImageUrl: product.ImageUrl,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              (product.Name == null || product.Name == "")
                  ? "Kedai Kawani's Menu"
                  : product.Name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Text(
              (product.Description == null || product.Description == "")
                  ? "by Kedai Kawani"
                  : product.Description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStylesBlack.caption,
            ),
            const SizedBox(height: 16.0),
            Text(
              NumberFormat.simpleCurrency(locale: "id-ID").format(
                (product.Price == null || product.Price == 0)
                    ? 0
                    : product.Price!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadImage extends StatelessWidget {
  const _LoadImage({super.key, required this.ImageUrl});

  final String? ImageUrl;

  @override
  Widget build(BuildContext context) {
    return (ImageUrl == null || ImageUrl == "")
        ? Padding(
            padding: const EdgeInsets.all(24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), //add border radius
              child: Image.asset(
                "assets/images/defaultMenuImage.png",
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.network(
              ImageUrl!,
              fit: BoxFit.cover,
            ),
          );
  }
}
