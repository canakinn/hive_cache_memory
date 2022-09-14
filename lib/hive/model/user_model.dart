// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:hive_cache_memory/constant/hive_constants.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveConstants.userTypeId)
class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? email;
  @HiveField(4)
  Address? address;
  @HiveField(5)
  String? phone;
  @HiveField(6)
  String? website;
  @HiveField(7)
  Company? company;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address ?? address?.toJson(),
        "phone": phone,
        "website": website,
        "company": company ?? company?.toJson(),
      };
}

@HiveType(typeId: HiveConstants.userTypeAddressId)
class Address {
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });
  @HiveField(0)
  String? street;
  @HiveField(1)
  String? suite;
  @HiveField(2)
  String? city;
  @HiveField(3)
  String? zipcode;
  @HiveField(4)
  Geo? geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: json["geo"] == null ? null : Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo ?? geo?.toJson(),
      };
}

@HiveType(typeId: HiveConstants.userTypeGeoId)
class Geo {
  Geo({
    this.lat,
    this.lng,
  });
  @HiveField(0)
  String? lat;
  @HiveField(1)
  String? lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

@HiveType(typeId: HiveConstants.userTypeCompanyId)
class Company {
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? catchPhrase;
  @HiveField(2)
  String? bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
