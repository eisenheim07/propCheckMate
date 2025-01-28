// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

List<HomeModel> homeModelFromJson(String str) => List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String homeModelToJson(List<HomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  bool? isEnabled;
  Info? info;

  HomeModel({
    this.isEnabled,
    this.info,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    isEnabled: json["isEnabled"],
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "isEnabled": isEnabled,
    "info": info?.toJson(),
  };
}

class Info {
  String? header;
  String? layout;
  String? type;
  List<Datum>? data;
  int? grid;
  int? rc;

  Info({
    this.header,
    this.layout,
    this.type,
    this.data,
    this.grid,
    this.rc,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    header: json["header"],
    layout: json["layout"],
    type: json["type"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    grid: json["grid"],
    rc: json["rc"],
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "layout": layout,
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "grid": grid,
    "rc": rc,
  };
}

class Datum {
  String? icon;
  String? name;
  String? img;
  String? price;
  String? desc;
  String? location;
  String? address;
  String? createdAt;
  double? ratings;
  List<int>? bhk;
  String? area;
  String? type;
  String? visit;
  String? phone;
  String? email;

  Datum({
    this.icon,
    this.name,
    this.img,
    this.price,
    this.desc,
    this.location,
    this.address,
    this.createdAt,
    this.ratings,
    this.bhk,
    this.area,
    this.type,
    this.visit,
    this.phone,
    this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    icon: json["icon"],
    name: json["name"],
    img: json["img"],
    price: json["price"],
    desc: json["desc"],
    location: json["location"],
    address: json["address"],
    createdAt: json["createdAt"],
    ratings: json["ratings"]?.toDouble(),
    bhk: json["bhk"] == null ? [] : List<int>.from(json["bhk"]!.map((x) => x)),
    area: json["area"],
    type: json["type"],
    visit: json["visit"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "name": name,
    "img": img,
    "price": price,
    "desc": desc,
    "location": location,
    "address": address,
    "createdAt": createdAt,
    "ratings": ratings,
    "bhk": bhk == null ? [] : List<dynamic>.from(bhk!.map((x) => x)),
    "area": area,
    "type": type,
    "visit": visit,
    "phone": phone,
    "email": email,
  };
}
