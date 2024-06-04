part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProducts extends ProductEvent {
  GetProducts ({
    required this.idCategory,
  });

  final String idCategory;

  @override
  List<Object?> get props => [idCategory];
}