class Product{
  late String? id;
  late String name;
  late String description;
  late num price;
  late num quantitiy;
  late String image;



  Product({required this.name,required this.description,required this.price,required this.quantitiy,required this.image});

  Product.fromMap(Map<String,dynamic> map){
    id=map['id'];
    name=map['name'];
    description=map['description'];
    price=map['price'];
    quantitiy=map['quantitiy'];
    image=map['image'];

  }
  Map<String,dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['quantitiy'] = quantitiy;
    map['image'] = image;

    return map;
  }
}