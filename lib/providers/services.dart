import 'package:http/http.dart' as http;
import 'package:k_kawani/data/models/category_list_model.dart';
import 'package:k_kawani/data/models/payment_method_list_model.dart';
import 'package:k_kawani/data/models/product_list_model.dart';
import 'package:k_kawani/data/models/transaction_id_model.dart';
import 'package:k_kawani/data/models/transaction_list_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/data/models/user_model.dart';
import 'package:k_kawani/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PosService {
  PosService({
    http.Client? httpClient,
    this.baseUrl = GlobalVariable.baseUrl,
    this.identityUrl = GlobalVariable.indentityUrl,
    this.version = '1',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final String identityUrl;
  final String version;
  final http.Client _httpClient;

  Uri getIdentityUrl({required String url}) {
    return Uri.parse('$identityUrl/$url');
  }

  Uri getUrl({
    required String url,
    Map<String, String>? extraParameters,
  }) {
    Map<String, String> queryParameters = {};
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: queryParameters,
    );
  }

  Map<String, String> getHeaders(String token) {
    String contentType = 'application/json';
    String bearerToken = 'Bearer $token';
    Map<String, String> headers = {
      'Content-Type': contentType,
      'Authorization': bearerToken,
    };
    return headers;
  }

  Future<AuthResponseModel> postLogin(AuthRequestModel authRequestModel) async {
    final response = await _httpClient.post(
      getIdentityUrl(url: 'api/v$version/user/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: authRequestModel.toJson(),
    );
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(response.body);
    } else {
      return AuthResponseModel.fromJson(response.body);
    }
  }

  Future<AuthResponseModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getIdentityUrl(
          url: 'api/v$version/user/get/${prefs.getString('IdUser')!}'),
      headers: getHeaders(prefs.getString('Token')!),
    );
    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(response.body);
    } else {
      return AuthResponseModel.fromJson(response.body);
    }
  }

  Future<CategoryListModel> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getUrl(url: 'api/v$version/category/get'),
      headers: getHeaders(prefs.getString('Token')!),
    );
    if (response.statusCode == 200) {
      return CategoryListModel.fromJson(response.body);
    } else {
      return CategoryListModel.fromJson(response.body);
    }
  }

  Future<ProductListModel> getProductsByCategory(String idCategory) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getUrl(url: 'api/v$version/product/get', extraParameters: {
        'id_category': idCategory,
      }),
      headers: getHeaders(prefs.getString('Token')!),
    );
    if (response.statusCode == 200) {
      return ProductListModel.fromJson(response.body);
    } else {
      return ProductListModel.fromJson(response.body);
    }
  }

  Future<TransactionIdModel> getTransactionId() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getUrl(url: 'api/v$version/order/transaction'),
      headers: getHeaders(prefs.getString('Token')!),
    );
    if (response.statusCode == 200) {
      return TransactionIdModel.fromJson(response.body);
    } else {
      return TransactionIdModel.fromJson(response.body);
    }
  }

  Future<TransactionOrderListModel> getOrderList(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getUrl(
        url: 'api/v$version/order/list',
        extraParameters: {'status': status},
      ),
      headers: getHeaders(prefs.getString('Token')!),
    );
    if (response.statusCode == 200) {
      return TransactionOrderListModel.fromJson(response.body);
    } else {
      return TransactionOrderListModel.fromJson(response.body);
    }
  }

  Future<int> postHoldOrder(TransactionOrderModel transactionOrder) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.post(
      getUrl(url: 'api/v$version/order/hold'),
      headers: getHeaders(prefs.getString('Token')!),
      body: transactionOrder.toJson(),
    );
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<PaymentMethodListModel> getPaymentMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.get(
      getUrl(url: 'api/v$version/paymentmethod/get'),
      headers: getHeaders(prefs.getString('Token')!),
    );
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      return PaymentMethodListModel.fromJson(response.body);
    } else {
      return PaymentMethodListModel.fromJson(response.body);
    }
  }

  Future<int> postPayment(TransactionOrderModel transactionOrder) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _httpClient.post(
      getUrl(url: 'api/v$version/order/payment'),
      headers: getHeaders(prefs.getString('Token')!),
      body: transactionOrder.toJson(),
    );
    // debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
