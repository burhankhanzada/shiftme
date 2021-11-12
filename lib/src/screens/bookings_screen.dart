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
          elevation: 0,
          title: const Text('Bookings'),
          backgroundColor: Theme.of(context).canvasColor,
          foregroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: tabs
                .map(
                  (type) => Tab(text: type),
                )
                .toList(),
          ),
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
