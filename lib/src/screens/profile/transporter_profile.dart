import 'package:flutter/material.dart';
import 'package:shiftme/src/app.dart';
import 'package:spaces/spaces.dart';

class TransporterProfileScreen extends StatelessWidget {
  const TransporterProfileScreen({key}) : super(key: key);

  @override
  build(context) {
    final user = App.user!;

    late final uid = user.uid!;

    late final name = user.name;

    late final number = user.phoneNumber;

    late final type = user.type;

    final transporter = App.transporter!;

    late final cnic = transporter.cnic;
    late final foundAt = transporter.foundAt;

    late final startTime = transporter.startTiming;
    late final endTime = transporter.endTiming;

    late final vehicileName = transporter.vehicle.name;
    late final loadingCapcaity = transporter.vehicle.loadingCapcaity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Transporter Profile"),
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        radius: 56,
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        number,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    Text(
                      "CNIC: $cnic",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Availibilty: $startTime - $endTime",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Vehicle: $vehicileName",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Load Capacity: $loadingCapcaity",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Can be found at",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      foundAt,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "Can be deliver at",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    for (var item in transporter.deliverTo)
                      Text(
                        item,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
