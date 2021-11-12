import 'package:flutter/material.dart';
import 'package:shiftme/src/screens/bookings_screen.dart';
import 'package:shiftme/src/screens/profile_screen.dart';
import 'package:spaces/spaces.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Image.asset(
          'assets/images/brand_logo.png',
          fit: BoxFit.contain,
          height: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SpacedRow.semiBig(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "User Name",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Bookings",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingsScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: SpacedColumn(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'From',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'To',
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: SpacedColumn(
                      padding: EdgeInsets.all(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Driver Name: Ali"),
                        Text("Vechile: Shezor"),
                        Text("Load Capacity: 500kg"),
                        Text("Availability: 10AM - 8PM"),
                        Text("Starting Price: 500"),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: SpacedColumn(
                      padding: EdgeInsets.all(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Driver Name: Ali"),
                        Text("Vechile: Ravi"),
                        Text("Load Capacity: 500kg"),
                        Text("Availability: 10AM - 8PM"),
                        Text("Starting Price: 500"),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: SpacedColumn(
                      padding: EdgeInsets.all(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Driver Name: Ali"),
                        Text("Vechile: Mazda"),
                        Text("Load Capacity: 500kg"),
                        Text("Availability: 10AM - 8PM"),
                        Text("Starting Price: 500"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
