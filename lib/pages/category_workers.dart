import 'package:flutter/material.dart';
import 'package:finalproject/components/worker_card.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:finalproject/view_models/workers_cubit/workers_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWorkers extends StatelessWidget {
  const CategoryWorkers({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Add filter logic here
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // Add sort logic here
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search workers...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FilterChip(
                      label: const Text('Rating'),
                      onSelected: (bool value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Location'),
                      onSelected: (bool value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Reviews'),
                      onSelected: (bool value) {},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<WorkersCubit, WorkersState>(
              builder: (context, state) {
                if (state is WorkersInitial || state is WorkersLoading) {
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
                          cubit.getProfileWorker(worker.uid);
                          return cubit;
                        },
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, profileState) {
                            if (profileState is ProfileInitial ||
                                profileState is ProfileLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (profileState is ProfileLoaded) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.workerProfile,
                                    arguments: {
                                      'profile': profileState.profile,
                                      'worker': worker,
                                    },
                                  );
                                },
                                child: WorkerCard(
                                  imageUrl: profileState.profile.imageUrl,
                                  name: profileState.profile.username,
                                  job: worker.job,
                                  rating: worker.sumofratings,
                                  reviews: worker.reviews,
                                  location: worker.location,
                                ),
                              );
                            } else if (profileState is ProfileError) {
                              return Center(
                                child: Text(profileState.message),
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
          ),
        ],
      ),
    );
  }
}
