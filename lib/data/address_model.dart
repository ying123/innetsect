class AddressModel{
  int id;
  String name;
  String phone;
  String address;
  bool isDefault;

  AddressModel({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.isDefault
  });

  factory AddressModel.formJson(Map<String,dynamic> json){
    return AddressModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      isDefault: json['isDefault']
    );
  }
}