class UserModel {
  final String username;
  final int age;
  final String? imageUrl; 

  UserModel({
    required this.username,
    required this.age,
    this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      age: map['age'],
      imageUrl: map['imageUrl'], 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'age': age,
      'imageUrl': imageUrl, 
    };
  }
}
