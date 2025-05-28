class Category {
  final int id;
  final String name;
  final String? icon;

  Category({
    required this.id,
    required this.name,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
