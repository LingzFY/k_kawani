part of 'payment_bloc.dart';

enum PaymentStatus {
  initial,
  ok,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  loading,
  error,
  setPaymentId,
  setNotes,
  setTotal,
  setFile,
  paid,
}

extension PaymentStatusX on PaymentStatus {
  bool get isInitial => this == PaymentStatus.initial;
  bool get isOk => this == PaymentStatus.ok;
  bool get isBadRequest => this == PaymentStatus.badRequest;
  bool get isUnauthorized => this == PaymentStatus.unauthorized;
  bool get isForbidden => this == PaymentStatus.forbidden;
  bool get isNotFound => this == PaymentStatus.notFound;
  bool get isLoading => this == PaymentStatus.loading;
  bool get isError => this == PaymentStatus.error;
  bool get isSetPayment => this == PaymentStatus.setPaymentId;
  bool get setNote => this == PaymentStatus.setNotes;
  bool get setTotal => this == PaymentStatus.setTotal;
  bool get setFile => this == PaymentStatus.setFile;
  bool get isPaid => this == PaymentStatus.paid;
}

class PaymentState extends Equatable {
  PaymentState({
    this.status = PaymentStatus.initial,
    TransactionOrderModel? transactionOrder,
    TransactionFileModel? transactionFile,
    PaymentMethodListModel? paymentMethodList,
    double? totalPayment,
    double? paymentMethodId,
    String? paymentRefference,
    String? notes,
  })  : transactionOrder = transactionOrder ?? TransactionOrderModel.empty,
        transactionFile = transactionFile ?? TransactionFileModel.empty,
        paymentMethodList = paymentMethodList ?? PaymentMethodListModel.empty,
        paymentMethodId = paymentMethodId ?? 0,
        totalPayment = totalPayment ?? 0,
        paymentRefference = paymentRefference ?? '',
        notes = notes ?? '';

  final PaymentStatus status;
  final TransactionOrderModel transactionOrder;
  final TransactionFileModel transactionFile;
  final PaymentMethodListModel paymentMethodList;
  final double paymentMethodId;
  final double totalPayment;
  final String paymentRefference;
  final String notes;

  @override
  List<Object?> get props => [
        status,
        transactionOrder,
        transactionFile,
        paymentMethodList,
        paymentMethodId,
        totalPayment,
        paymentRefference,
        notes,
      ];

  PaymentState copyWith({
    PaymentStatus? status,
    TransactionOrderModel? transactionOrder,
    TransactionFileModel? transactionFile,
    PaymentMethodListModel? paymentMethodList,
    double? paymentMethodId,
    double? totalPayment,
    String? paymentRefference,
    String? notes,
  }) {
    return PaymentState(
      status: status ?? this.status,
      transactionOrder: transactionOrder ?? this.transactionOrder,
      transactionFile:  transactionFile ?? this.transactionFile,
      paymentMethodList: paymentMethodList ?? this.paymentMethodList,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      totalPayment: totalPayment ?? this.totalPayment,
      paymentRefference: paymentRefference ?? this.paymentRefference,
      notes: notes ?? this.notes,
    );
  }
}
