import 'package:finalproject/services/order_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/order_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  final orderservices = OrderServiceImpl();

  void getOrdersworker(String workerID) async {
    emit(OrdersLoading());
    try {
      final orders = await orderservices.getWorkerOrders(workerID);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  void getOrders(String userID) async {
    emit(OrdersLoading());
    try {
      final orders = await orderservices.getOrders(userID);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
