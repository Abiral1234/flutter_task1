import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../domain/product_model.dart';
import 'order_bloc_event.dart';
import 'order_bloc_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Dio dio;

  OrderBloc({required this.dio}) : super(OrderInitial()) {
    on<FetchOrders>(_fetchOrders);
  }

  Future<void> _fetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    const String url =
        'https://oriflamenepal.com/api/product/for-public/smart-sync-lipstick-233';

    try {
      final Response response = await dio.get(url);

      if (response.statusCode == 200) {
        ProductResponse? model = ProductResponse.fromJson(response.data);
        emit(OrderLoaded(model));
        // print("the model is" + model.toString());
        // print('Product Data: ${response.data}');
      } else {
        emit(OrderError('Error While Fetching Data'));
        // print('Failed to fetch product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      emit(OrderError('Error While Fetching Data'));
      // print('Error occurred while fetching product: $e');
    }
  }
}
