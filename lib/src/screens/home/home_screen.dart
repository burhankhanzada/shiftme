import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/components/label_value.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/models/user.dart';
import 'package:shiftme/src/models/vehicle.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/drawer.dart';
import 'package:shiftme/src/screens/profile/transporter_profile.dart';
import 'package:shiftme/src/screens/tranport_details_screen.dart';
import 'package:shiftme/src/utils/firbase.dart';
import 'package:spaces/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TransportCard> list = [];
  List<TransportCard> filteredList = [];

  var isLoading = true;

  String from = '';
  String to = '';

  final startTimings = ['8 AM', '9 AM', '10 AM', '11 AM', '12 AM'];
  final endTimings = ['5 PM', '6 PM', '7 PM', '8 PM', '9 PM'];

  var startTime;
  var endTime;

  List<Vehicle> vehicles = [
    const Vehicle(name: 'Suzuki Ravi', loadingCapcaity: '600 Kg'),
    const Vehicle(name: 'Hyundai  Shehzore', loadingCapcaity: '3,500 Kg'),
  ];

  var vehicle;

  Future<void> getTransporters() async {
    final transposterFuture = await transportersRef.get();

    for (final doc in transposterFuture.docs) {
      final transporter = doc.data();

      final usersFuture = await usersRef.doc(doc.id).get();

      final user = usersFuture.data()!;

      if (doc.id != App.user!.uid) {
        list.add(TransportCard(user: user, transporter: transporter));
      }
    }

    setState(() {
      filteredList = list;
      isLoading = false;
    });
  }

  void filterList() {
    // if (from.isNotEmpty && to.isNotEmpty) {
    //   filteredList = list
    //       .where((element) => element.transporter.foundAt.contains(from))
    //       .where((element) => element.transporter.deliverTo.contains(to))
    //       .toList();
    // } else if (from.isNotEmpty && to.isEmpty) {
    //   filteredList = list
    //       .where((element) => element.transporter.foundAt.contains(from))
    //       .toList();
    // } else if (from.isEmpty && to.isNotEmpty) {
    //   filteredList = list
    //       .where((element) => element.transporter.deliverTo.contains(to))
    //       .toList();
    // } else {
    //   filteredList = list;
    // }

    filteredList = list;

    if (from.isNotEmpty) {
      filteredList = filteredList
          .where((element) => element.transporter.foundAt.contains(from))
          .toList();
    }

    if (to.isNotEmpty) {
      filteredList = filteredList
          .where((element) => element.transporter.deliverTo.contains(to))
          .toList();
    }

    if (startTime != null) {
      filteredList = filteredList
          .where((element) => element.transporter.startTiming == startTime)
          .toList();
    }

    if (endTime != null) {
      filteredList = filteredList
          .where((element) => element.transporter.endTiming == endTime)
          .toList();
    }

    if (vehicle != null) {
      filteredList = filteredList
          .where((element) => element.transporter.vehicle == vehicle)
          .toList();
    }
  }

  @override
  void initState() {
    getTransporters();
    super.initState();
  }

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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SpacedColumn(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Filter Search',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              SpacedColumn(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Availibility Timings'),
                                      DropdownButton<String>(
                                        value: startTime,
                                        items: startTimings
                                            .map(
                                              (item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            startTime = value!;
                                          });
                                        },
                                      ),
                                      const Text('to'),
                                      DropdownButton<String>(
                                        value: endTime,
                                        items: endTimings
                                            .map(
                                              (item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            endTime = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Vehicle'),
                                      DropdownButton<Vehicle>(
                                        value: vehicle,
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return vehicles.map((item) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(item.name),
                                                const SizedBox(width: 8),
                                                Text(item.loadingCapcaity),
                                              ],
                                            );
                                          }).toList();
                                        },
                                        items: vehicles
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<Vehicle>(
                                                value: item,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(item.name),
                                                    Text(item.loadingCapcaity),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              vehicle = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
          drawer: const HomeDrawer(),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'From',
                      ),
                      onChanged: (value) {
                        setState(() {
                          from = value;
                          filterList();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'To',
                      ),
                      onChanged: (value) {
                        setState(() {
                          to = value;
                          filterList();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (filteredList.isEmpty)
                const Center(child: Text('No transporters fround'))
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return filteredList[index];
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: filteredList.length,
                ),
            ],
          ),
        );
      },
    );
  }
}

class TransportCard extends StatelessWidget {
  const TransportCard({Key? key, required this.user, required this.transporter})
      : super(key: key);

  final User user;
  final Transporter transporter;

  @override
  Widget build(BuildContext context) {
    final vehicle = transporter.vehicle;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransporterProfileScreen(
              user: user,
              transporter: transporter,
            ),
          ),
        );
      },
      child: Card(
        child: SizedBox(
          width: double.infinity,
          child: SpacedColumn(
            padding: const EdgeInsets.all(8),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelValueWidget(label: 'Driver Name:', value: user.name),
              LabelValueWidget(label: 'Vechile:', value: vehicle.name),
              LabelValueWidget(
                label: 'Load Capacity:',
                value: vehicle.loadingCapcaity,
              ),
              LabelValueWidget(
                label: 'Availability:',
                value: '${transporter.startTiming} - ${transporter.endTiming}',
              ),
              LabelValueWidget(
                label: 'Can be found at:',
                value: transporter.foundAt,
              ),
              //  LabelValueWidget(
              //   label: 'Can be deliver to:',
              //   value: to,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
