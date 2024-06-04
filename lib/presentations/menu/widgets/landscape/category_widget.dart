import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/bloc/category_bloc/category_bloc.dart';
import 'package:k_kawani/data/bloc/product_bloc/product_bloc.dart';
import 'package:k_kawani/data/models/category_model.dart';

typedef CategoryCLicked = Function(CategoryModel categorySelected);

class CategoryWidgetLandscape extends StatelessWidget {
  const CategoryWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 40.0,
      width: double.infinity,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.idSelected == '') {
            context.read<CategoryBloc>().add(
                  SelectCategory(
                    idSelected: '',
                  ),
                );
          }
          if (state.status.isOk || state.status.isSelected) {
            return SizedBox(
              height: 40.0,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => CategoryItemWidget(
                  key: ValueKey(state.categories.Items[index].Id),
                  category: state.categories.Items[index],
                  callback: (CategoryModel categorySelected) {
                    context.read<ProductBloc>().add(
                          GetProducts(idCategory: categorySelected.Id),
                        );
                    context.read<CategoryBloc>().add(
                          SelectCategory(
                            idSelected: categorySelected.Id,
                          ),
                        );
                  },
                ),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(
                  width: 24.0,
                ),
                itemCount: state.categories.Items.length,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
    required this.category,
    required this.callback,
  });

  final CategoryModel category;
  final CategoryCLicked callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(category),
      child: BlocSelector<CategoryBloc, CategoryState, bool>(
        selector: (state) =>
            (state.status.isSelected && state.idSelected == category.Id)
                ? true
                : false,
        builder: (context, state) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: state ? Colors.orangeAccent : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                category.Name!,
                style: TextStyle(color: state ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
