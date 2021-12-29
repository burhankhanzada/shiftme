import 'package:flutter/material.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/components/label_value.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/models/shiftme_user.dart';
import 'package:spaces/spaces.dart';

class TransporterProfileScreen extends StatelessWidget {
  TransporterProfileScreen({key, ShiftMeUser? user, Transporter? transporter})
      : user = user ?? App.user!,
        transporter = transporter ?? App.transporter!,
        super(key: key);

  final ShiftMeUser user;

  final Transporter transporter;

  @override
  Widget build(context) {
    late final vehicle = transporter.vehicle;

    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Transporter Profile'),
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
                      child: Text(
                        user.name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    Align(
                      child: Text(
                        user.phoneNumber,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    LabelValueWidget(
                      label: 'CNIC:',
                      value: transporter.cnic,
                      textStyle: textStyle,
                    ),
                    LabelValueWidget(
                      label: 'Availibilty:',
                      value:
                          '${transporter.startTiming} - ${transporter.endTiming}',
                      textStyle: textStyle,
                    ),
                    LabelValueWidget(
                      label: 'Vechile:',
                      value: vehicle.name,
                      textStyle: textStyle,
                    ),
                    LabelValueWidget(
                      label: 'Load Capacity:',
                      value: vehicle.loadingCapcaity,
                      textStyle: textStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Can be found at',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Text(
                      transporter.foundAt,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Can be deliver at',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
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
