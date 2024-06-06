import 'package:k_kawani/data/models/category_list_model.dart';
import 'package:k_kawani/data/models/payment_method_list_model.dart';
import 'package:k_kawani/data/models/product_list_model.dart';
import 'package:k_kawani/data/models/transaction_id_model.dart';
import 'package:k_kawani/data/models/transaction_list_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/data/models/user_model.dart';
import 'package:k_kawani/providers/services.dart';

class PosRepository {
  const PosRepository({
    required this.service,
  });

  final PosService service;

  // Authentication
  Future<AuthResponseModel> postLogin(AuthRequestModel authRequestModel) =>
      service.postLogin(authRequestModel);
  Future<AuthResponseModel> getUser() => service.getUser();

  // Category
  Future<CategoryListModel> getCategories() => service.getCategories();
  Future<ProductListModel> getProductsByCategory(String idCategory) async =>
      service.getProductsByCategory(idCategory);

  // Transaction
  Future<TransactionIdModel> getTransactionId() => service.getTransactionId();
  Future<TransactionOrderListModel> getOrderList(String status) => service.getOrderList(status);
  Future<TransactionOrderModel> getOrder(String idTransaction) => service.getOrder(idTransaction);
  Future<int> postHoldOrder(TransactionOrderModel transactionOrder) => service.postHoldOrder(transactionOrder);

  // Payment
  Future<PaymentMethodListModel> getPaymentMethod() => service.getPaymentMethod();
  Future<int> postPayment(TransactionOrderModel transactionOrder) => service.postPayment(transactionOrder);
}
