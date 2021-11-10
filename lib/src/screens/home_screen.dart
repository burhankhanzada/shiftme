import 'package:flutter/material.dart';
import 'package:shiftme/src/screens/profile.dart';
import 'package:spaces/spaces.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ShiftMe"),
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
                    const CircleAvatar(
                      backgroundColor: Colors.brown,
                      radius: 36,
                    ),
                    Text(
                      "User Name",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text("Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              const ListTile(
                title: Text("Bookings"),
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
