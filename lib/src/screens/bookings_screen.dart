import 'package:flutter/material.dart';
import 'package:spaces/spaces.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['In Progress', 'Completed'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onPrimary,
            indicatorColor: Theme.of(context).colorScheme.onPrimary,
            tabs: tabs
                .map(
                  (type) => Tab(text: type),
                )
                .toList(),
          ),
          title: const Text('Bookings '),
        ),
        body: TabBarView(
          children: tabs
              .map(
                (type) => Expanded(
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
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
