import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/drawer.dart';
import 'package:shiftme/src/screens/tranport_details_screen.dart';
import 'package:spaces/spaces.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  Widget build(context) {
    return Consumer<AuthUserProvider>(
      builder: (context, loginStore, child) {
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
          drawer: const HomeDrawer(),
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
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TransporterDetailsScreen(),
                          ),
                        );
                      },
                      child: const Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: SpacedColumn(
                            padding: EdgeInsets.all(8),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver Name: Ali'),
                              Text('Vechile: Shezor'),
                              Text('Load Capacity: 500kg'),
                              Text('Availability: 10AM - 8PM'),
                              Text('Starting Price: 500'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TransporterDetailsScreen(),
                          ),
                        );
                      },
                      child: const Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: SpacedColumn(
                            padding: EdgeInsets.all(8),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver Name: Ali'),
                              Text('Vechile: Ravi'),
                              Text('Load Capacity: 500kg'),
                              Text('Availability: 10AM - 8PM'),
                              Text('Starting Price: 500'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TransporterDetailsScreen(),
                          ),
                        );
                      },
                      child: const Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: SpacedColumn(
                            padding: EdgeInsets.all(8),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver Name: Ali'),
                              Text('Vechile: Mazda'),
                              Text('Load Capacity: 500kg'),
                              Text('Availability: 10AM - 8PM'),
                              Text('Starting Price: 500'),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
