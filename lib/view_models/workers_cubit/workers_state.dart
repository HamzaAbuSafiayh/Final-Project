part of 'workers_cubit.dart';

sealed class WorkersState {}

final class WorkersInitial extends WorkersState {}

final class WorkersLoading extends WorkersState {}

final class WorkersLoaded extends WorkersState {
  final List<WorkerModel> workers;
  WorkersLoaded(this.workers);
}

final class WorkersError extends WorkersState {
  final String message;
  WorkersError(this.message);
}
