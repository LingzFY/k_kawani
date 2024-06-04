part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  ok,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  loading,
  error,
}

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isOk => this == ProductStatus.ok;
  bool get isBadRequest => this == ProductStatus.badRequest;
  bool get isUnauthorized => this == ProductStatus.unauthorized;
  bool get isForbidden => this == ProductStatus.forbidden;
  bool get isNotFound => this == ProductStatus.notFound;
  bool get isLoading => this == ProductStatus.loading;
  bool get isError => this == ProductStatus.error;
}

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    ProductListModel? products,
    String? idCategory,
  })  : products = products ?? ProductListModel.empty,
        idCategory = idCategory ?? '';

  final ProductListModel products;
  final ProductStatus status;
  final String idCategory;

  @override
  List<Object?> get props => [status, products, idCategory];

  ProductState copyWith({
    ProductListModel? products,
    ProductStatus? status,
    String? idCategory,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      idCategory: idCategory ?? this.idCategory,
    );
  }
}
