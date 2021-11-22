import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaces/spaces.dart';

class TransporterDetailsScreen extends StatelessWidget {
  const TransporterDetailsScreen({key}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Transport Details"),
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 56,
                    child: const Icon(
                      Icons.person,
                      size: 96,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                "Driver: Ali",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Mobile Number: +92 3XXXXXXXXX",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "CNIC: XXXXX - XXXXXXX - X",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Availibilty: 10 AM - 8 PM",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Vehicle: Shazor",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Load Capacity: 500 Kg",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Staring Price: 500",
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
                "Nursery Frurniture Market, Shah-e-Faisal",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Can be deliver at",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "North Karachi",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Gulshan-e-Hijri",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Gulshan-e-Iqbal",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Gulstan-e-Johar",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
