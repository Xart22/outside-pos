import 'package:pos_getx/app/data/model/categories_model.dart';

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
      };
}
