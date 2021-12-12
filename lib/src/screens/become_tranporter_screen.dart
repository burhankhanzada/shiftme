import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/models/user.dart';
import 'package:shiftme/src/models/vehicle.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/utils/firbase.dart';
import 'package:spaces/spaces.dart';

class BecomeTransporterScreen extends StatefulWidget {
  const BecomeTransporterScreen({key}) : super(key: key);

  @override
  State<BecomeTransporterScreen> createState() =>
      _BecomeTransporterScreenState();
}

class _BecomeTransporterScreenState extends State<BecomeTransporterScreen> {
  final _cnicController = MaskedTextController(mask: '00000 - 0000000 - 0');
  final _foundAtController = TextEditingController();
  final _vechileNoController = MaskedTextController(mask: 'AAAA - 0000');
  final _deliverToController = TextEditingController();

  late String type;

  final startTimings = ['8 AM', '9 AM', '10 AM', '11 AM', '12 AM'];
  final endTimings = ['5 PM', '6 PM', '7 PM', '8 PM', '9 PM'];

  late String startTime = startTimings[0];
  late String endTime = endTimings[0];

  List<Vehicle> vehicles = [
    const Vehicle(name: 'Suzuki Ravi', loadingCapcaity: '600 Kg'),
    const Vehicle(name: 'Hyundai  Shehzore', loadingCapcaity: '3,500 Kg'),
  ];

  late Vehicle vehicle = vehicles[0];

  List<String> deliverTo = [
    'North Karachi',
    'Gulshan-e-Hijri',
  ];

  var isLoding = false;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Become Transporter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              setState(() {
                isLoding = true;
              });

              vehicle = vehicle.copyWith(vehicleNo: _vechileNoController.text);

              final transporter = Transporter(
                cnic: _cnicController.text,
                foundAt: _foundAtController.text,
                startTiming: startTime,
                endTiming: endTime,
                deliverTo: deliverTo,
                vehicle: vehicle,
              );

              final uid = context.read<AuthUserProvider>().firebaseUser!.uid;

              await transportersRef.doc(uid).set(transporter);

              await usersRef.doc(uid).update({'type': UserType.transporter});

              App.user = App.user!.copyWith(type: UserType.transporter);

              App.transporter = transporter;

              setState(() {
                isLoding = false;
              });

              await Navigator.of(context).push(
                MaterialPageRoute(builder: (contex) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoding
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SpacedColumn.semiBig(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Vehicle'),
                        DropdownButton<Vehicle>(
                          value: vehicle,
                          selectedItemBuilder: (BuildContext context) {
                            return vehicles.map((item) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                (item) => DropdownMenuItem<Vehicle>(
                                  value: item,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.name),
                                      Text(item.loadingCapcaity),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              vehicle = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    TextField(
                      controller: _vechileNoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vehcile no',
                        hintText: 'ABCD - 1234',
                      ),
                    ),
                    TextField(
                      controller: _cnicController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CNIC',
                        hintText: '12345 - 6789123 - 4',
                      ),
                    ),
                    TextField(
                      controller: _foundAtController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Can be found at',
                        hintText: 'ABC, XYZ',
                      ),
                    ),
                    Text(
                      'Can deliver to',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    for (var item in deliverTo)
                      Text(
                        item,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    SpacedRow(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _deliverToController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Can deliver to',
                              hintText: 'ABC, XYZ',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Add'),
                          onPressed: () {
                            setState(() {
                              deliverTo.add(_deliverToController.text);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
