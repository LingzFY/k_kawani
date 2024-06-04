import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:k_kawani/data/bloc/order_bloc/transaction_bloc.dart';
import 'package:k_kawani/data/models/transaction_item_model.dart';
import 'package:k_kawani/theme/app_fonts.dart';

class ListWidgetLandscape extends StatelessWidget {
  const ListWidgetLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: state.transactionOrder.Items.length,
          itemBuilder: (BuildContext context, int i) {
            return ListItemWidget(
              index: i,
              transactionItem: state.transactionOrder.Items[i],
              callbackAddQty: (TransactionItemModel transactionItem) {
                context.read<TransactionBloc>().add(
                      IncreaseQty(targetIndex: i),
                    );
              },
              callbackReduceQty: (TransactionItemModel transactionItem) {
                context.read<TransactionBloc>().add(
                      DecreaseQty(targetIndex: i),
                    );
              },
              callbackRemoveItem: (TransactionItemModel transactionItem) {
                context.read<TransactionBloc>().add(
                      RemoveTransactionItemList(
                        transactionItemModel: state.transactionOrder.Items[i],
                      ),
                    );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 24);
          },
        );
      },
    );
  }
}

typedef TransactionItemClicked = Function(
    TransactionItemModel transactionItemModel);

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.transactionItem,
    required this.callbackAddQty,
    required this.callbackReduceQty,
    required this.callbackRemoveItem,
    required this.index,
  });

  final TransactionItemModel transactionItem;
  final TransactionItemClicked callbackAddQty;
  final TransactionItemClicked callbackReduceQty;
  final TransactionItemClicked callbackRemoveItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: loadImage(transactionItem.Product?.ImageUrl),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionItem.Product!.Name!,
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: "id-ID")
                          .format(transactionItem.Product?.Price!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackReduceQty(transactionItem),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
              Container(
                width: 48,
                alignment: Alignment.center,
                child: Text(
                  transactionItem.Qty!.toString(),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackAddQty(transactionItem),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 0,
                  ),
                  child: TextField(
                    style: AppTextStylesBlack.body2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add Note...',
                      hintStyle: AppTextStylesBlack.body2,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    onChanged: (value) {
                      context.read<TransactionBloc>().add(
                            AddNote(
                              newNote: value.toString(),
                              targetIndex: index,
                            ),
                          );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 48,
                width: 48,
                child: IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => callbackRemoveItem(transactionItem),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  loadImage(String? imageUrl) {
    return (imageUrl == null || imageUrl == "")
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), //add border radius
              child: Image.asset(
                "assets/images/defaultMenuImage.png",
                fit: BoxFit.cover,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0), //add border radius
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          );
  }
}
