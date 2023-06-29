import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna/models/product_model.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/providers/firebase_providers.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

final adminRepositoryProvider = Provider((ref) {
  return AdminRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class AdminRepository {
  final FirebaseFirestore _firestore;
  AdminRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.productCollection);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);


  Future<void> addProduct(ProductModel product) async {
    try {
      return _posts.doc(product.pid).set(product.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Future<void> addMessage(String msg) async {
  //   try {
  //     http.Response userRes = await http.get(
  //       Uri.parse('$uri?text=hiiiii'),
  //     );
  //     print(userRes.body.toString());
  //   } on FirebaseFunctionsException catch (error) {
  //     print("in error");
  //     print(error.toString());
  //     print(error.code.toString());
  //     print(error.details.toString());
  //     print(error.message.toString());
  //   }
  // }
}
