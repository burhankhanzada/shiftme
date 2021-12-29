import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/models/shiftme_user.dart';

final usersRef =
    FirebaseFirestore.instance.collection('users').withConverter<ShiftMeUser>(
          fromFirestore: (snapshot, options) =>
              ShiftMeUser.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        );

final transportersRef = FirebaseFirestore.instance
    .collection('transporters')
    .withConverter<Transporter>(
      fromFirestore: (snapshot, options) =>
          Transporter.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    );
