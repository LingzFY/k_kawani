part of 'transaction_bloc.dart';

enum TransactionStatus {
  initial,
  ok,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  loading,
  error,
  changeOption,
  add,
  remove,
  increaseQty,
  decreaseQty,
  addNote,
  clearAll,
  hold,
  selected,
}

extension TransactionStatusX on TransactionStatus {
  bool get isInitial => this == TransactionStatus.initial;
  bool get isOk => this == TransactionStatus.ok;
  bool get isBadRequest => this == TransactionStatus.badRequest;
  bool get isUnauthorized => this == TransactionStatus.unauthorized;
  bool get isForbidden => this == TransactionStatus.forbidden;
  bool get isNotFound => this == TransactionStatus.notFound;
  bool get isLoading => this == TransactionStatus.loading;
  bool get isError => this == TransactionStatus.error;
  bool get isChangeOption => this == TransactionStatus.changeOption;
  bool get isAdd => this == TransactionStatus.add;
  bool get isRemove => this == TransactionStatus.remove;
  bool get isIncrease => this == TransactionStatus.increaseQty;
  bool get isDecrease => this == TransactionStatus.decreaseQty;
  bool get isAddNote => this == TransactionStatus.addNote;
  bool get isClear => this == TransactionStatus.clearAll;
  bool get isHold => this == TransactionStatus.hold;
  bool get isSelected => this == TransactionStatus.selected;
}

class TransactionState extends Equatable {
  TransactionState({
    this.status = TransactionStatus.initial,
    TransactionOrderModel? transactionOrder,
    TransactionOrderListModel? transactionOrderList,
    double? dineOption,
    double? totalPrice,
    String? notes,
  })  : transactionOrder = transactionOrder ?? TransactionOrderModel.empty,
        transactionOrderList = transactionOrderList ?? TransactionOrderListModel.empty,
        dineOption = dineOption ?? 0,
        totalPrice = totalPrice ?? 0,
        notes = notes ?? '';

  final TransactionOrderModel transactionOrder;
  final TransactionOrderListModel transactionOrderList;
  final TransactionStatus status;
  final double dineOption;
  final double totalPrice;
  final String notes;

  @override
  List<Object?> get props => [
        status,
        transactionOrder,
        transactionOrderList,
        dineOption,
        totalPrice,
        notes,
      ];

  TransactionState copyWith({
    TransactionOrderModel? transactionOrder,
    TransactionOrderListModel? transactionOrderList,
    TransactionStatus? status,
    double? dineOption,
    double? totalPrice,
    String? notes,
  }) {
    return TransactionState(
      transactionOrder: transactionOrder ?? this.transactionOrder,
      transactionOrderList: transactionOrderList ?? this.transactionOrderList,
      status: status ?? this.status,
      dineOption: dineOption ?? this.dineOption,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }
}
