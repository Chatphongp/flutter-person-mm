class Person {
  int id;
  String name;
  String telephoneNumber;
  String address;

  Person ({
    this.id,
    this.name,
    this.telephoneNumber,
    this.address
  });

  factory Person.fromJson(Map<String, dynamic> json) => new Person(
    id : json["id"],
    name : json["name"],
    telephoneNumber: json["telephoneNumber"],
    address: json["address"]
  );

  Map<String, dynamic> toJson() => {
    "name" : name,
    "telephoneNumber" : telephoneNumber,
    "address" : address,
  };

  Map<String, dynamic> toJsonWithId() => {
    "id" : id,
    "name" : name,
    "telephoneNumber" : telephoneNumber,
    "address" : address,
  };

}