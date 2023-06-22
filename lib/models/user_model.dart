import 'package:collection/collection.dart';

class UserModel {
  final String name;
  final String uid;
  final String hid;
  final bool isFilled;
  final String address;
  final bool isAdmin;
  final Map<String, int> cart;

  UserModel({
    required this.name,
    required this.uid,
    required this.hid,
    required this.isFilled,
    required this.address,
    required this.isAdmin,
    required this.cart,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? hid,
    bool? isFilled,
    String? address,
    bool? isAdmin,
    Map<String, int>? cart,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      hid: hid ?? this.hid,
      isFilled: isFilled ?? this.isFilled,
      address: address ?? this.address,
      isAdmin: isAdmin ?? this.isAdmin,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'hid': hid,
      'isFilled': isFilled,
      'address': address,
      'isAdmin': isAdmin,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      hid: map['hid'] as String,
      isFilled: map['isFilled'] as bool,
      address: map['address'] as String,
      isAdmin: map['isAdmin'] as bool,
      cart: (map['cart'] as Map<dynamic, dynamic>)
          .map((key, value) => MapEntry(key as String, value as int)),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, hid: $hid, isFilled: $isFilled, address: $address, isAdmin: $isAdmin, cart: $cart)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other.name == name &&
        other.uid == uid &&
        other.hid == hid &&
        other.isFilled == isFilled &&
        other.address == address &&
        other.isAdmin == isAdmin &&
        mapEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        hid.hashCode ^
        isFilled.hashCode ^
        address.hashCode ^
        isAdmin.hashCode ^
        cart.hashCode;
  }
}
