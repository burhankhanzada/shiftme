import 'package:flutter/material.dart';
import 'package:spaces/spaces.dart';

class BecomeTransporterScreen extends StatelessWidget {
  const BecomeTransporterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Become Transporter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SpacedColumn.semiBig(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CNIC',
                  hintText: 'XXXXX - XXXXXXX - X',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Availibility Timings',
                  hintText: '10 AM - 8 PM',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Vachile no',
                  hintText: 'XXXX - XXXX',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Vachile Type/Model',
                  hintText: 'Ravi/Shehzor/Mazda',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Can be found at',
                  hintText: 'Nursery Fruniture Market, Shah-e-Faisal',
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: const Text("Add Area can deliver to"),
                  onPressed: () {},
                ),
              ),
              Text(
                "Can be deliver at",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
