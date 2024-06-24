import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/order_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
}
