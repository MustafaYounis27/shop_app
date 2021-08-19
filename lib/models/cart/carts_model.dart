import 'package:shop_app/models/home_model.dart';

class CartsModel
{
  bool status;
  CartData data;

  CartsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CartData.fromJson(json['data']);
  }
}

class CartData
{
  List<CartItem> cartItems = [];
  dynamic subTotal;
  dynamic total;

  CartData.fromJson(Map<String, dynamic> json)
  {
    total = json['total'];
    subTotal = json['sub_total'];
    json['cart_items'].forEach((element)
    {
      cartItems.add(CartItem.fromJson(element));
    });
  }
}

class CartItem
{
  int id;
  int quantity;
  ProductModel product;

  CartItem.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    quantity = json['quantity'];
    product = ProductModel.fromJson(json['product']);
  }
}

