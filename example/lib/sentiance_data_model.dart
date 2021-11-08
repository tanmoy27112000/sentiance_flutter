// To parse this JSON data, do
//
//     final sentianceDataModel = sentianceDataModelFromJson(jsonString);

import 'dart:convert';

SentianceDataModel sentianceDataModelFromJson(String str) => SentianceDataModel.fromJson(json.decode(str));

String sentianceDataModelToJson(SentianceDataModel data) => json.encode(data.toJson());

class SentianceDataModel {
  SentianceDataModel({
    required this.userId,
    required this.sentianceToken,
    required this.sentianceStatus,
  });

  String userId;
  String sentianceToken;
  String sentianceStatus;

  factory SentianceDataModel.fromJson(Map<String, dynamic> json) => SentianceDataModel(
    userId: json["userId"],
    sentianceToken: json["sentianceToken"],
    sentianceStatus: json["sentianceStatus"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "sentianceToken": sentianceToken,
    "sentianceStatus": sentianceStatus,
  };
}
