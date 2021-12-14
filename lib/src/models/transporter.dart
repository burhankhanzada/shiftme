import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shiftme/src/models/vehicle.dart';

@immutable
class Transporter {
  final String userID;
  final String cnic;
  final String foundAt;
  final String startTiming;
  final String endTiming;
  final List<String> deliverTo;

  final Vehicle vehicle;

  const Transporter({
    required this.userID,
    required this.cnic,
    required this.foundAt,
    required this.startTiming,
    required this.endTiming,
    required this.deliverTo,
    required this.vehicle,
  });

  Transporter copyWith({
    String? userID,
    String? cnic,
    String? foundAt,
    String? startTiming,
    String? endTiming,
    List<String>? deliverTo,
    Vehicle? vehicle,
  }) {
    return Transporter(
      userID: userID ?? this.userID,
      cnic: cnic ?? this.cnic,
      foundAt: foundAt ?? this.foundAt,
      startTiming: startTiming ?? this.startTiming,
      endTiming: endTiming ?? this.endTiming,
      deliverTo: deliverTo ?? this.deliverTo,
      vehicle: vehicle ?? this.vehicle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'cnic': cnic,
      'foundAt': foundAt,
      'startTiming': startTiming,
      'endTiming': endTiming,
      'deliverTo': deliverTo,
      'vehicle': vehicle.toMap(),
    };
  }

  factory Transporter.fromMap(Map<String, dynamic> map) {
    return Transporter(
      userID: map['userID'] ?? '',
      cnic: map['cnic'] ?? '',
      foundAt: map['foundAt'] ?? '',
      startTiming: map['startTiming'] ?? '',
      endTiming: map['endTiming'] ?? '',
      deliverTo: List<String>.from(map['deliverTo']),
      vehicle: Vehicle.fromMap(map['vehicle']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transporter.fromJson(String source) =>
      Transporter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transporter(userID: $userID, cnic: $cnic, foundAt: $foundAt, startTiming: $startTiming, endTiming: $endTiming, deliverTo: $deliverTo, vehicle: $vehicle)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transporter &&
        other.userID == userID &&
        other.cnic == cnic &&
        other.foundAt == foundAt &&
        other.startTiming == startTiming &&
        other.endTiming == endTiming &&
        listEquals(other.deliverTo, deliverTo) &&
        other.vehicle == vehicle;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        cnic.hashCode ^
        foundAt.hashCode ^
        startTiming.hashCode ^
        endTiming.hashCode ^
        deliverTo.hashCode ^
        vehicle.hashCode;
  }
}
