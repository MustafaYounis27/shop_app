import 'package:shop_app/models/address/address_model.dart';

class GetAddressModel
{
  bool status;
  GetAddressData data;

  GetAddressModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = GetAddressData.fromJson(json['data']);
  }
}
class GetAddressData
{
  List<AddressData> data = [];

  GetAddressData.fromJson(Map<String, dynamic> json)
  {
    json['data'].forEach((element)
    {
      data.add(AddressData.fromJson(element));
    });
  }
}