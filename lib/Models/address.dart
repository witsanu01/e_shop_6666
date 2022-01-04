class AddressModel {
  String name;
  String phoneNumber;
  String nameby;
  String sale;
  String state;
  String pincode;

  AddressModel(
      {this.name,
      this.phoneNumber,
      this.nameby,
      this.sale,
      this.state,
      this.pincode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    nameby = json['nameby'];
    sale = json['sale'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['nameby'] = this.nameby;
    data['sale'] = this.sale;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}
