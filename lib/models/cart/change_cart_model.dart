class ChageCartModel
{
  bool status;
  String message;
  AddToCartData data;

  ChageCartModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = AddToCartData.fromJson(json['data']);
  }

}

class AddToCartData
{
  int id;

  AddToCartData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
  }
}