import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  final List<Setting> data;

  SettingsModel({
    required this.data,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        data: List<Setting>.from(json["data"].map((x) => Setting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Setting {
  final int id;
  final String name;
  final String value;

  Setting({
    required this.id,
    required this.name,
    required this.value,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
      };
}
