class Variant {
  final int id;
  final String name;
  final int rulesMin;
  final int rulesMax;
  final List<Option> options;

  Variant({
    required this.id,
    required this.name,
    required this.rulesMin,
    required this.rulesMax,
    required this.options,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        name: json["name"],
        rulesMin: json["rules_min"],
        rulesMax: json["rules_max"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rules_min": rulesMin,
        "rules_max": rulesMax,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  final int id;
  final int variantId;
  final String name;
  final int price;
  int position;

  Option({
    required this.id,
    required this.variantId,
    required this.name,
    required this.price,
    required this.position,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        variantId: json["variant_id"],
        name: json["name"],
        price: json["price"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant_id": variantId,
        "name": name,
        "price": price,
        "position": position,
      };
}
