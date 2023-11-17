// To parse this JSON data, do
//
//     final stateListModel = stateListModelFromJson(jsonString);

import 'dart:convert';

StateListModel stateListModelFromJson(String str) =>
    StateListModel.fromJson(json.decode(str));

String stateListModelToJson(StateListModel data) => json.encode(data.toJson());

class StateListModel {
  StateListModel({
    required this.message,
    required this.stateList,
  });

  String message;
  List<StateList> stateList;

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
        message: json["message"],
        stateList: List<StateList>.from(
            json["stateList"].map((x) => StateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "stateList": List<dynamic>.from(stateList.map((x) => x.toJson())),
      };
}

class StateList {
  StateList({
    required this.id,
    required this.state,
  });

  int id;
  String state;

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json["id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
      };
}
