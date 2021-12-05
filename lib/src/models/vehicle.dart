import 'dart:convert';

class Vehicle {
  final String name;
  final String loadingCapcaity;
  final String? vehicleNo;

  Vehicle({
    required this.name,
    required this.loadingCapcaity,
    this.vehicleNo,
  });

  Vehicle copyWith({
    String? name,
    String? loadingCapcaity,
    String? vehicleNo,
  }) {
    return Vehicle(
      name: name ?? this.name,
      loadingCapcaity: loadingCapcaity ?? this.loadingCapcaity,
      vehicleNo: vehicleNo ?? this.vehicleNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'loadingCapcaity': loadingCapcaity,
      'vehicleNo': vehicleNo,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      name: map['name'],
      loadingCapcaity: map['loadingCapcaity'],
      vehicleNo: map['vehicleNo'] != null ? map['vehicleNo'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  @override
  String toString() =>
      'Vehicle(name: $name, loadingCapcaity: $loadingCapcaity, vehicleNo: $vehicleNo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vehicle &&
        other.name == name &&
        other.loadingCapcaity == loadingCapcaity &&
        other.vehicleNo == vehicleNo;
  }

  @override
  int get hashCode =>
      name.hashCode ^ loadingCapcaity.hashCode ^ vehicleNo.hashCode;
}
