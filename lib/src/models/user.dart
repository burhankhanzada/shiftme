import 'dart:convert';

class UserType {
  static String customer = 'Customer';
  static String transporter = 'Transporter';
}

class User {
  final String? uid;
  final String name;
  final String? imageUrl;
  final String phoneNumber;
  final String type;

  User({
    this.uid,
    required this.name,
    this.imageUrl,
    required this.phoneNumber,
    String? type,
  }) : type = type ?? UserType.customer;

  User copyWith({
    String? uid,
    String? name,
    String? imageUrl,
    String? phoneNumber,
    String? type,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] != null ? map['uid'] : null,
      name: map['name'],
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] : null,
      phoneNumber: map['phoneNumber'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, imageUrl: $imageUrl, phoneNumber: $phoneNumber, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.phoneNumber == phoneNumber &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        type.hashCode;
  }
}
