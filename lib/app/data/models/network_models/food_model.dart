class FoodModel {
  FoodModel(
      {this.foodId,
      this.foodCategory,
      this.foodType,
      this.foodName,
      this.tourId,
      this.price});
  String? foodId;
  String? foodCategory;
  String? foodType;
  String? foodName;
  String? tourId;
  String? price;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'food_id': foodId,
        'food_category': foodCategory,
        'food_type': foodType,
        'food_name': foodName,
        'tour_id': tourId,
        'price': price,
      };
  static FoodModel fromJson(Map<String, dynamic> json) => FoodModel(
        foodId: json['food_id'] as String,
        foodCategory: json['food_category'] as String,
        foodType: json['food_type'] as String,
        foodName: json['food_name'] as String,
        tourId: json['tour_id'] as String,
        price: json['price'] as String,
      );
}
