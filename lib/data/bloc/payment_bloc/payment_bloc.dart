import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/models/payment_method_list_model.dart';
import 'package:k_kawani/data/models/transaction_file_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required this.posRepository,
  }) : super(PaymentState()) {
    on<GetPaymentMethod>(_mapGetPaymentMethodEventToState);
    on<SetPayment>(_mapSetPaymentEventToState);
    on<SetTotalPayment>(_mapSetTotalPaymentEventToState);
    on<SetPaymentFile>(_mapSetPaymentFileEventToState);
    on<SetNotePayment>(_mapSetNotePaymentEventToState);
    on<PostPayment>(_mapPostPaymentEventToState);
  }

  final PosRepository posRepository;

  void _mapGetPaymentMethodEventToState(
      GetPaymentMethod event, Emitter<PaymentState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: PaymentStatus.loading));
      PaymentMethodListModel paymentMethodList =
          await posRepository.getPaymentMethod();
      TransactionOrderModel transactionOrder = event.transactionOrder;
      transactionOrder.PaymentMethodId = 1;
      transactionOrder.PaymentRefference = '';
      transactionOrder.TotalPayment = 0;
      transactionOrder.PaymentFile = TransactionFileModel();
      switch (paymentMethodList.Code) {
        case 200:
          emit(
            state.copyWith(
              status: PaymentStatus.ok,
              paymentMethodList: paymentMethodList,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: PaymentStatus.badRequest,
              paymentMethodList: paymentMethodList,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: PaymentStatus.unauthorized,
              paymentMethodList: paymentMethodList,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: PaymentStatus.forbidden,
              paymentMethodList: paymentMethodList,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: PaymentStatus.notFound,
              paymentMethodList: paymentMethodList,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      // debugPrint(error.toString());
      emit(state.copyWith(status: PaymentStatus.error));
    }
  }

  void _mapSetPaymentEventToState(
      SetPayment event, Emitter<PaymentState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.PaymentMethodId = event.paymentMethodId;
    transactionOrder.PaymentRefference = event.paymentRefference;
    transactionOrder.TotalPayment = transactionOrder.TotalPrice;
    // transactionOrder.PaymentFile = event.transactionFile;

    if (transactionOrder.PaymentMethodId == 1) {
      transactionOrder.TotalPayment = 0;
      transactionOrder.PaymentFile = TransactionFileModel();
    }

    emit(
      state.copyWith(
        status: PaymentStatus.setPaymentId,
        paymentMethodId: event.paymentMethodId,
        paymentRefference: event.paymentRefference,
        // transactionFile: event.transactionFile,
        transactionOrder: transactionOrder,
      ),
    );
  }

  void _mapSetTotalPaymentEventToState(
      SetTotalPayment event, Emitter<PaymentState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.TotalPayment = event.totalPayment;

    emit(
      state.copyWith(
        status: PaymentStatus.setTotal,
        transactionOrder: transactionOrder,
        totalPayment: event.totalPayment,
      ),
    );
  }

  void _mapSetPaymentFileEventToState(
      SetPaymentFile event, Emitter<PaymentState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.PaymentFile = event.transactionFile;

    emit(
      state.copyWith(
        status: PaymentStatus.setFile,
        transactionOrder: transactionOrder,
      ),
    );
  }

  void _mapSetNotePaymentEventToState(
      SetNotePayment event, Emitter<PaymentState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.Description = event.notes;

    emit(
      state.copyWith(
        status: PaymentStatus.setNotes,
        transactionOrder: transactionOrder,
        notes: event.notes,
      ),
    );
  }

  void _mapPostPaymentEventToState(
      PostPayment event, Emitter<PaymentState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: PaymentStatus.loading));
      int paymentResponse =
          await posRepository.postPayment(event.transactionOrder);
      switch (paymentResponse) {
        case 200:
          emit(
            state.copyWith(
              status: PaymentStatus.paid,
              transactionOrder: event.transactionOrder,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: PaymentStatus.badRequest,
              transactionOrder: event.transactionOrder,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: PaymentStatus.unauthorized,
              transactionOrder: event.transactionOrder,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: PaymentStatus.forbidden,
              transactionOrder: event.transactionOrder,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: PaymentStatus.notFound,
              transactionOrder: event.transactionOrder,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      // debugPrint(error.toString());
      emit(state.copyWith(status: PaymentStatus.error));
    }
  }
}
