import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';

class Menu {
  final int id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String imageLocal;
  final int stock;
  final int isActive;
  final int isOnline;
  final Category category;
  final List<VariantElement> variantsElement;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.imageLocal,
    required this.stock,
    required this.isActive,
    required this.isOnline,
    required this.category,
    required this.variantsElement,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        image: json["image"],
        imageLocal: json["image_local"],
        stock: json["stock"],
        isActive: json["is_active"],
        isOnline: json["is_online"],
        category: Category.fromJson(json["category"]),
        variantsElement: List<VariantElement>.from(
            json["variants"].map((x) => VariantElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "image_local": imageLocal,
        "stock": stock,
        "is_active": isActive,
        "is_online": isOnline,
        "category": category.toJson(),
        "variants": List<dynamic>.from(variantsElement.map((x) => x.toJson())),
      };
}

class VariantElement {
  final int id;
  final Variant variant;
  final int position;

  VariantElement({
    required this.id,
    required this.variant,
    required this.position,
  });

  factory VariantElement.fromJson(Map<String, dynamic> json) => VariantElement(
        id: json["id"],
        variant: Variant.fromJson(json["variant"]),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant": variant.toJson(),
        "position": position,
      };
}
