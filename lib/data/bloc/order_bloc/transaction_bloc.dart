import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_kawani/data/models/transaction_id_model.dart';
import 'package:k_kawani/data/models/transaction_item_model.dart';
import 'package:k_kawani/data/models/transaction_list_model.dart';
import 'package:k_kawani/data/models/transaction_model.dart';
import 'package:k_kawani/providers/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    required this.posRepository,
  }) : super(TransactionState()) {
    on<GetTransactionId>(_mapGetTransactionIdEventToState);
    on<ChangeDineOption>(_mapChangeDineOptionEventToState);
    on<ClearAllItem>(_mapClearAllItemEventToState);
    on<AddTransactionItemList>(_mapAddTransactionItemListEventToState);
    on<RemoveTransactionItemList>(_mapRemoveTransactionItemListEventToState);
    on<IncreaseQty>(_mapIncreaseQtyEventToState);
    on<DecreaseQty>(_mapDecreaseQtyEventToState);
    on<AddNote>(_mapAddTransactionItemNoteEventToState);
    on<HoldTransaction>(_mapHoldTransactionEventToState);
    on<GetOrderList>(_mapGetHoldOrderListEventToState);
    on<GetOrder>(_mapGetHoldOrderEventToState);
  }

  final PosRepository posRepository;

  double setTotalPrice(List<TransactionItemModel> items) {
    double totalPrice = 0;
    if (items.isNotEmpty) {
      for (int index = 0; index < items.length; index++) {
        totalPrice =
            totalPrice + (items[index].Qty! * items[index].Product!.Price!);
      }
    }
    return totalPrice;
  }

  void _mapGetTransactionIdEventToState(
      GetTransactionId event, Emitter<TransactionState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: TransactionStatus.loading));
      TransactionIdModel transactionId = await posRepository.getTransactionId();
      TransactionOrderModel transactionOrder = TransactionOrderModel.empty;
      switch (transactionId.Code) {
        case 200:
          transactionOrder.Id = transactionId.Id;
          transactionOrder.TrxNo = transactionId.TrxNo;
          transactionOrder.IdTransaction = transactionId.Id;
          transactionOrder.Items = [];
          transactionOrder.DineOption = 0;
          transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);
          emit(
            state.copyWith(
              status: TransactionStatus.ok,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: TransactionStatus.badRequest,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: TransactionStatus.unauthorized,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: TransactionStatus.forbidden,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: TransactionStatus.notFound,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapChangeDineOptionEventToState(
      ChangeDineOption event, Emitter<TransactionState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.DineOption = event.dineOption;

    emit(
      TransactionState(
        status: TransactionStatus.changeOption,
        transactionOrder: transactionOrder,
        dineOption: event.dineOption,
      ),
    );
  }

  void _mapClearAllItemEventToState(
      ClearAllItem event, Emitter<TransactionState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.Items = [];
    transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);

    emit(
      TransactionState(
        status: TransactionStatus.clearAll,
        transactionOrder: transactionOrder,
        totalPrice: transactionOrder.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemListEventToState(
      AddTransactionItemList event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrder.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    TransactionOrderModel transactionOrder = state.transactionOrder;
    if (targetIndex == -1) {
      transactionOrder.Items.add(event.transactionItemModel);
    }
    transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);

    emit(
      TransactionState(
        status: TransactionStatus.add,
        transactionOrder: transactionOrder,
        totalPrice: transactionOrder.TotalPrice,
      ),
    );
  }

  void _mapRemoveTransactionItemListEventToState(
      RemoveTransactionItemList event, Emitter<TransactionState> emit) async {
    final int targetIndex = state.transactionOrder.Items
        .indexWhere((element) => element.Id == event.transactionItemModel.Id);
    TransactionOrderModel transactionOrder = state.transactionOrder;
    if (targetIndex != -1) {
      transactionOrder.Items.remove(event.transactionItemModel);
    }
    transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);

    emit(
      TransactionState(
        status: TransactionStatus.remove,
        transactionOrder: transactionOrder,
        totalPrice: transactionOrder.TotalPrice,
      ),
    );
  }

  void _mapIncreaseQtyEventToState(
      IncreaseQty event, Emitter<TransactionState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    transactionOrder.Items[event.targetIndex].Qty =
        transactionOrder.Items[event.targetIndex].Qty! + 1;

    transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);

    emit(
      TransactionState(
        status: TransactionStatus.increaseQty,
        transactionOrder: transactionOrder,
        totalPrice: transactionOrder.TotalPrice,
      ),
    );
  }

  void _mapDecreaseQtyEventToState(
      DecreaseQty event, Emitter<TransactionState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    if (transactionOrder.Items[event.targetIndex].Qty! > 1) {
      transactionOrder.Items[event.targetIndex].Qty =
          transactionOrder.Items[event.targetIndex].Qty! - 1;
    }

    transactionOrder.TotalPrice = setTotalPrice(transactionOrder.Items);

    emit(
      TransactionState(
        status: TransactionStatus.decreaseQty,
        transactionOrder: transactionOrder,
        totalPrice: transactionOrder.TotalPrice,
      ),
    );
  }

  void _mapAddTransactionItemNoteEventToState(
      AddNote event, Emitter<TransactionState> emit) async {
    TransactionOrderModel transactionOrder = state.transactionOrder;
    if (event.targetIndex != -1) {
      transactionOrder.Items[event.targetIndex].Notes = event.newNote;
      transactionOrder.Items[event.targetIndex].Description = event.newNote;
    }

    emit(
      TransactionState(
          status: TransactionStatus.addNote,
          transactionOrder: transactionOrder,
          notes: transactionOrder.Items[event.targetIndex].Notes),
    );
  }

  void _mapGetHoldOrderListEventToState(
      GetOrderList event, Emitter<TransactionState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: TransactionStatus.loading));
      TransactionOrderListModel transactionOrderList = await posRepository.getOrderList(event.parameter);
      switch (transactionOrderList.Code) {
        case 200:
          emit(
            state.copyWith(
              status: TransactionStatus.ok,
              transactionOrderList: transactionOrderList,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: TransactionStatus.badRequest,
              transactionOrderList: transactionOrderList,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: TransactionStatus.unauthorized,
              transactionOrderList: transactionOrderList,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: TransactionStatus.forbidden,
              transactionOrderList: transactionOrderList,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: TransactionStatus.notFound,
              transactionOrderList: transactionOrderList,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapGetHoldOrderEventToState(
      GetOrder event, Emitter<TransactionState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: TransactionStatus.loading));
      TransactionOrderModel transactionOrder = await posRepository.getOrder(event.idTransaction);
      switch (transactionOrder.Code) {
        case 200:
          emit(
            state.copyWith(
              status: TransactionStatus.ok,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: TransactionStatus.badRequest,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: TransactionStatus.unauthorized,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: TransactionStatus.forbidden,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: TransactionStatus.notFound,
              transactionOrder: transactionOrder,
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }

  void _mapHoldTransactionEventToState(
      HoldTransaction event, Emitter<TransactionState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(state.copyWith(status: TransactionStatus.loading));
      int responseCode = await posRepository.postHoldOrder(event.transactionOrder);
      switch (responseCode) {
        case 200:
          emit(
            state.copyWith(
              status: TransactionStatus.hold
            ),
          );
          break;
        case 400:
          emit(
            state.copyWith(
              status: TransactionStatus.badRequest
            ),
          );
          break;
        case 401:
          prefs.setBool('isActive', false);
          emit(
            state.copyWith(
              status: TransactionStatus.unauthorized
            ),
          );
          break;
        case 403:
          emit(
            state.copyWith(
              status: TransactionStatus.forbidden
            ),
          );
          break;
        case 404:
          emit(
            state.copyWith(
              status: TransactionStatus.notFound
            ),
          );
          break;
        default:
      }
    } catch (error) {
      emit(state.copyWith(status: TransactionStatus.error));
    }
  }
}
