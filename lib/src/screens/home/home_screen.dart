import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/app.dart';
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
    if (from.isNotEmpty && to.isNotEmpty) {
      filteredList = list
          .where((element) => element.transporter.foundAt.contains(from))
          .where((element) => element.transporter.deliverTo.contains(to))
          .toList();
    } else if (from.isNotEmpty && to.isEmpty) {
      filteredList = list
          .where((element) => element.transporter.foundAt.contains(from))
          .toList();
    } else if (from.isEmpty && to.isNotEmpty) {
      filteredList = list
          .where((element) => element.transporter.deliverTo.contains(to))
          .toList();
    } else {
      filteredList = list;
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
                onPressed: () {},
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
              Text('Driver Name: ${user.name}'),
              Text('Vechile: ${vehicle.name}'),
              Text('Load Capacity: ${vehicle.loadingCapcaity}'),
              Text(
                  'Availability: ${transporter.startTiming} - ${transporter.endTiming}'),
              Text('Can be found at: ${transporter.foundAt}'),
            ],
          ),
        ),
      ),
    );
  }
}
