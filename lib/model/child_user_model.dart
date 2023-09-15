import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String phone;
  String childemail;
  String parentemail;
  String type;
  String id;
  String imageUrl;

  UserModel({
    required this.name,
    required this.phone,
    required this.childemail,
    required this.parentemail,
    required this.type,
    required this.id,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'childemail': childemail,
      'parentemail': parentemail,
      'type': type,
      'id': id,
    };
  }

  UserModel copyWith({
    String? name,
    String? phone,
    String? childemail,
    String? parentemail,
    String? type,
    String? id,
    String? imageUrl,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      childemail: childemail ?? this.childemail,
      parentemail: parentemail ?? this.parentemail,
      type: type ?? this.type,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'childemail': childemail});
    result.addAll({'parentemail': parentemail});
    result.addAll({'type': type});
    result.addAll({'id': id});
    result.addAll({'imageUrl': imageUrl});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      childemail: map['childemail'] ?? '',
      parentemail: map['parentemail'] ?? '',
      type: map['type'] ?? '',
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }


  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, phone: $phone, childemail: $childemail, parentemail: $parentemail, type: $type, id: $id, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.name == name &&
      other.phone == phone &&
      other.childemail == childemail &&
      other.parentemail == parentemail &&
      other.type == type &&
      other.id == id &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      phone.hashCode ^
      childemail.hashCode ^
      parentemail.hashCode ^
      type.hashCode ^
      id.hashCode ^
      imageUrl.hashCode;
  }
}
