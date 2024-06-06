part of 'transaction_bloc.dart';

class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTransactionId extends TransactionEvent {}

class ChangeDineOption extends TransactionEvent {
  ChangeDineOption({
    required this.dineOption,
  });
  final double dineOption;
  @override
  List<Object?> get props => [dineOption];
}

class AddTransactionItemList extends TransactionEvent {
  AddTransactionItemList({
    required this.transactionItemModel,
  });
  final TransactionItemModel transactionItemModel;
  @override
  List<Object?> get props => [transactionItemModel];
}

class RemoveTransactionItemList extends TransactionEvent {
  RemoveTransactionItemList({
    required this.transactionItemModel,
  });
  final TransactionItemModel transactionItemModel;
  @override
  List<Object?> get props => [transactionItemModel];
}

class ClearAllItem extends TransactionEvent {}

class IncreaseQty extends TransactionEvent {
  IncreaseQty({
    required this.targetIndex,
  });
  final int targetIndex;
  @override
  List<Object?> get props => [targetIndex];
}

class DecreaseQty extends TransactionEvent {
  DecreaseQty({
    required this.targetIndex,
  });
  final int targetIndex;
  @override
  List<Object?> get props => [targetIndex];
}

class AddNote extends TransactionEvent {
  AddNote({
    required this.targetIndex,
    required this.newNote,
  });
  final int targetIndex;
  final String newNote;
  @override
  List<Object?> get props => [targetIndex, newNote];
}

class HoldTransaction extends TransactionEvent {
  HoldTransaction({
    required this.transactionOrder,
  });
  final TransactionOrderModel transactionOrder;
  @override
  List<Object?> get props => [transactionOrder];
}

class GetOrderList extends TransactionEvent {
  GetOrderList({
    required this.parameter,
  });
  final String parameter;
  @override
  List<Object?> get props => [parameter];
}

class GetOrder extends TransactionEvent {
  GetOrder({
    required this.idTransaction,
  });
  final String idTransaction;
  @override
  List<Object?> get props => [idTransaction];
}
