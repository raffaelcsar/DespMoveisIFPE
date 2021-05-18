class Pet {
  String name;
  String species;
  int price;
  String picture;

  Pet({this.name, this.species, this.price, this.picture});

  Pet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    species = json['species'];
    price = json['price'];
    picture = json['picture'];
  }
}
