import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.country = '',
    this.zipCode = '',
  });

  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String country;
  final String zipCode;

  User copyWith(
      {String? id,
      String? fullName,
      String? email,
      String? address,
      String? country,
      String? zipCode}) {
    return User(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        address: address ?? this.address,
        country: country ?? this.country,
        zipCode: zipCode ?? this.zipCode);
  }

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot.id,
      fullName: snapshot['fullName'],
      email: snapshot['email'],
      address: snapshot['address'],
      country: snapshot['country'],
      zipCode: snapshot['zipCode'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'country': country,
      'zipCode': zipCode,
    };
  }

  @override
  List<Object?> get props => [id, fullName, email, address, country, zipCode];
}
