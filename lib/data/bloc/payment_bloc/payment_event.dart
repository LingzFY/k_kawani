part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPaymentMethod extends PaymentEvent {
  GetPaymentMethod ({
    required this.transactionOrder,
  });

  final TransactionOrderModel transactionOrder;

  @override
  List<Object?> get props => [transactionOrder];
}

class SetPayment extends PaymentEvent {
  SetPayment ({
    required this.paymentMethodId,
    required this.paymentRefference,
  });

  final double paymentMethodId;
  final String paymentRefference;

  @override
  List<Object?> get props => [paymentMethodId, paymentRefference];
}

class SetTotalPayment extends PaymentEvent {
  SetTotalPayment ({
    required this.totalPayment,
  });

  final double totalPayment;

  @override
  List<Object?> get props => [totalPayment];
}

class SetPaymentFile extends PaymentEvent {
  SetPaymentFile ({
    required this.transactionFile,
  });

  final TransactionFileModel transactionFile;

  @override
  List<Object?> get props => [transactionFile];
}

class SetNotePayment extends PaymentEvent {
  SetNotePayment ({
    required this.notes,
  });

  final String notes;

  @override
  List<Object?> get props => [notes];
}

class PostPayment extends PaymentEvent {
  PostPayment ({
    required this.transactionOrder,
  });

  final TransactionOrderModel transactionOrder;

  @override
  List<Object?> get props => [transactionOrder];
}