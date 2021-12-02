import 'dart:convert';

enum UserType { customer, tranposrter }

class User {
  final String name;
  final String? imageUrl;
  final String phoneNumber;
  final UserType type = UserType.customer;

  User({
    required this.name,
    this.imageUrl,
    required this.phoneNumber,
  });

  User copyWith({
    String? name,
    String? imageUrl,
    String? phoneNumber,
  }) {
    return User(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] : null,
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(name: $name, imageUrl: $imageUrl, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode ^ phoneNumber.hashCode;
}
