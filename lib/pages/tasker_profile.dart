import 'package:finalproject/services/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalproject/models/user_model.dart';
import 'package:finalproject/models/worker_model.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';

class WorkerProfile extends StatelessWidget {
  const WorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final chatservices = ChatServicesImpl();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final profile = arguments['profile'] as UserModel;
    final worker = arguments['worker'] as WorkerModel;
    final selectedDate = DateTime.now();
    const selectedTime = TimeOfDay(hour: 13, minute: 0);
    final user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasker Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
        Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profile.imageUrl),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        profile.username, // UserName from firebase
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 45),
                      IconButton(
                          color: Colors.grey,
                          onPressed: () {
                            //do the chat
                            chatservices.accessChat(user, worker.uid);
                            Navigator.of(context)
                                .pushNamed(AppRoutes.chat, arguments: {
                              'userid': user,
                              'workerid': worker.uid,
                            });
                          },
                          icon: const Icon(Icons.chat)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                          '${worker.sumofratings} (${worker.reviews} ratings)'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.check_circle_outline),
                      SizedBox(width: 4),
                      Text('117 Furniture Assembly tasks',style: TextStyle(color: Color.fromRGBO(36, 150, 137, 1), fontWeight: FontWeight.bold)), //firebase,
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.directions_car),
                      SizedBox(width: 4),
                      Text('Vehicles: Car, Minivan/SUV') //firebase,
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.build),
                      SizedBox(width: 4),
                      Text(
                          'Tools: Dolly, Ladder, Power drill, Power washer') //firebase,
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 0.3,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Skills & experience',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'I have 5 years of furniture assembly. I have my own tools and am willing and able to help you.', //firebase
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 0.3,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Photos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: worker.photos.length >
                          1, // Disable infinite scroll if there's only one photo
                      reverse: false,
                      autoPlay: worker.photos.length >
                          1, // Disable auto play if there's only one photo
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: worker.photos.map((photoUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Image.network(
                                    photoUrl,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                              child: Image.network(
                                      photoUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 0.3,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Ratings & reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${worker.sumofratings} (${worker.reviews} ratings)',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildRatingBar('5 star', 78),
                  _buildRatingBar('4 star', 0),
                  _buildRatingBar('3 star', 1),
                  _buildRatingBar('2 star', 15),
                  _buildRatingBar('1 star', 6),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // const Divider(
                //   thickness: 0.3,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${worker.cost}/hr',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showScheduleModal(context, selectedDate, selectedTime,
                            profile, worker);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(36, 150, 137, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Select',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, int percentage) {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(label, style: const TextStyle(color: Color.fromRGBO(36, 150, 137, 1), fontWeight: FontWeight.bold),
        ),),
        SizedBox(
          width: 330,
          child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(20),
              value: percentage / 100.0,
              backgroundColor: Colors.grey[300],
              color: const Color.fromRGBO(36, 150, 137, 1),
            ),
          ),
        const SizedBox(width: 8),
        Text('$percentage%'),
      ],
    );
  }

  void _showScheduleModal(BuildContext context, DateTime selectedDate,
      TimeOfDay selectedTime, UserModel profile, WorkerModel worker) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      builder: (BuildContext context) {
        DateTime selectedDate0 = selectedDate;
        TimeOfDay selectedTime0 = selectedTime;
        String name = profile.username.split(' ')[0];
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$name's Schedule",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, MMM d, yyyy').format(selectedDate0),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate0,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate0) {
                            setState(() {
                              selectedDate0 = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTime0.format(context),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime0,
                          );
                          if (pickedTime != null &&
                              pickedTime != selectedTime0) {
                            setState(() {
                              selectedTime0 = pickedTime;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        AppRoutes.confirmation,
                        arguments: {
                          'worker': worker,
                          'profile': profile,
                          'selectedDate': selectedDate0,
                          'selectedTime': selectedTime0,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Select & Continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
