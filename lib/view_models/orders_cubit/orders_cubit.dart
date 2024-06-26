import 'dart:async';

import 'package:finalproject/services/order_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/order_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  final orderservices = OrderServiceImpl();
  StreamSubscription<List<OrderModel>>? _ordersSubscription;

  void getOrdersWorker(String workerID) {
    emit(OrdersLoading());
    _ordersSubscription?.cancel();
    _ordersSubscription = orderservices.getWorkerOrders(workerID).listen(
      (orders) {
        emit(OrdersLoaded(orders));
      },
      onError: (e) {
        emit(OrdersError(e.toString()));
      },
    );
  }

  void getOrders(String userID) {
    emit(OrdersLoading());
    _ordersSubscription?.cancel();
    _ordersSubscription = orderservices.getOrders(userID).listen(
      (orders) {
        emit(OrdersLoaded(orders));
      },
      onError: (e) {
        emit(OrdersError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
