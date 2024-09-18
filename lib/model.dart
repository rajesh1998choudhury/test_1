// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

List<ProductListModel> productListModelFromJson(String str) =>
    List<ProductListModel>.from(
        json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListModel {
  final String? id;
  final String? name;
  final String? moq;
  final String? price;
  final String? discountedPrice;

  ProductListModel({
    this.id,
    this.name,
    this.moq,
    this.price,
    this.discountedPrice,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        name: json["name"],
        moq: json["moq"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "moq": moq,
        "price": price,
        "discounted_price": discountedPrice,
      };
}
