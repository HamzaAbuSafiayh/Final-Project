import 'package:finalproject/models/worker_model.dart';
import 'package:finalproject/services/workers_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workers_state.dart';

class WorkersCubit extends Cubit<WorkersState> {
  WorkersCubit() : super(WorkersInitial());
  final workerServices = WorkersServicesImpl();

  void getWorkers() async{
    emit(WorkersLoading());
    try { 
      final List<WorkerModel> workers = await workerServices.getWorkers();
      emit(WorkersLoaded(workers));
    } catch (e) {
      emit(WorkersError(e.toString()));
    }
  }
  void getWorkersByCat(String categroy) async{
    emit(WorkersLoading());
    try { 
      final List<WorkerModel> workers = await workerServices.getWorkersByCat(categroy);
      emit(WorkersLoaded(workers));
    } catch (e) {
      emit(WorkersError(e.toString()));
    }
  }
}
