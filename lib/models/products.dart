
import 'package:shopsphere/models/reviews.dart';
class Products {

  final int id;
  final String title;
  final String desc;
  final String category;
  final double price;
  final String image;
  final double rate;
  final List<Reviews>reviews;
  Products({
    required this.id,
    required this.title,
    required this.desc,
    required this.category,
    required this.price,
    required this.image ,
    required this.rate,
    required this.reviews,
  });
  factory Products.fromJson(Map<String,dynamic>json){
    return Products(
      id: json["id"], 
      title:json["title"], 
      desc: json["description"], 
      category:json["category"], 
      price:( json['price'] as num).toDouble(),
      image:json['thumbnail']as String? ?? 'https://via.placeholder.com/500',
      rate: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews:(json['reviews'] as List<dynamic>?)
      ?.map((e)=>Reviews.fromJson(e)).toList()??[]

      );
  }


  String get imgUrl{
    return image;
  }
}