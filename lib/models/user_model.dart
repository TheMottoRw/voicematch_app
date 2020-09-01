class User {
  final int id;
  final String name;
  final String contact;
  final String imageUrl;

  User({this.id, this.name, this.contact, this.imageUrl});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      contact: json['phone'],
      imageUrl: json['id']!=0?'assets/logo.png':'assets/kabaka.png'
    );
  }
}
