import 'package:finalproject/components/worker_card.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:finalproject/view_models/workers_cubit/workers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWorkers extends StatelessWidget {
  const CategoryWorkers({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: BlocBuilder<WorkersCubit, WorkersState>(
        builder: (context, state) {
          if (state is WorkersInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WorkersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WorkersLoaded) {
            return ListView.builder(
              itemCount: state.workers.length,
              itemBuilder: (context, index) {
                final worker = state.workers[index];
                return BlocProvider(
                  create: (context) {
                    final cubit = ProfileCubit();
                    cubit.getProfileWorker(state.workers[index].uid);
                    return cubit;
                  },
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProfileLoaded) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.workerProfile,
                              arguments: {
                                'profile': state.profile,
                                'worker': worker,
                              },
                            );
                          },
                          child: WorkerCard(
                            imageUrl: state.profile.imageUrl,
                            name: state.profile.username,
                            job: worker.job,
                            rating: worker.sumofratings,
                            reviews: worker.reviews,
                            location: worker.location,
                          ),
                        );
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return const CircularProgressIndicator.adaptive();
                      }
                    },
                  ),
                );
              },
            );
          } else if (state is WorkersError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
