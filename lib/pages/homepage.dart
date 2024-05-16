import 'package:finalproject/view_models/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.location_on,
          size: 35,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.search,
              size: 25,
            ),
          )
        ],
        title: const Text(
          'Tulkarm City',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is CategoriesLoaded) {
            final filteredCategories = state.categories.where((category) {
              return category.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    'I need help with',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                      itemCount: filteredCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    filteredCategories[index].imageUrl,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 150,
                                  ),
                                ),
                                Text(
                                  filteredCategories[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is CategoriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
