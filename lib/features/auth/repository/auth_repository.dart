import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luna/core/providers/firebase_providers.dart';
import 'package:luna/core/utils.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../models/user_model.dart';


final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: ref.read(authProvider),
      firestore: ref.read(firestoreProvider),
      googleSignIn: ref.read(googleSignInProvider)),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  AuthRepository(
      {required this.auth,
      required this.firestore,
      required this.googleSignIn});

  CollectionReference get _users =>
      firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => auth.authStateChanges();

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }


  Future<UserModel?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential = await auth.signInWithCredential(credential);

      UserModel? userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        final hid = const Uuid().v1();
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'No Name',
          uid: userCredential.user!.uid,
          hid: hid,
          isFilled: false,
          isAdmin: false,
          address: '',
          cart: {},
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getCurrentUserData();
      }
      return userModel;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  void updateUserData(BuildContext context, UserModel userModel) {
    try {
      _users.doc(userModel.uid).update(userModel.toMap());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> logOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

  // void verifyOTP({
  //   required BuildContext context,
  //   required String verificationId,
  //   required String userOTP,
  // }) async {
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: userOTP,
  //     );
  //     await auth.signInWithCredential(credential);
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       UserInformationScreen.routeName,
  //       (route) => false,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context: context, content: e.message!);
  //   }
  // }

  // void saveUserDataToFirebase({
  //   required String name,
  //   required File? profilePic,
  //   required ProviderRef ref,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     String uid = auth.currentUser!.uid;
  //     String photoUrl =
  //         'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

  //     if (profilePic != null) {
  //       photoUrl = await ref
  //           .read(commonFirebaseStorageRepositoryProvider)
  //           .storeFileToFirebase(
  //             'profilePic/$uid',
  //             profilePic,
  //           );
  //     }

  //     var user = UserModel(
  //       name: name,
  //       uid: uid,
  //       profilePic: photoUrl,
  //       isOnline: true,
  //       phoneNumber: auth.currentUser!.phoneNumber!,
  //       groupId: [],
  //     );

  //     await firestore.collection('users').doc(uid).set(user.toMap());

  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const MobileLayoutScreen(),
  //       ),
  //       (route) => false,
  //     );
  //   } catch (e) {
  //     showSnackBar(context: context, content: e.toString());
  //   }
  // }

  // Stream<UserModel> userData(String userId) {
  //   return firestore.collection('users').doc(userId).snapshots().map(
  //         (event) => UserModel.fromMap(
  //           event.data()!,
  //         ),
  //       );
  // }

  // void setUserState(bool isOnline) async {
  //   await firestore.collection('users').doc(auth.currentUser!.uid).update({
  //     'isOnline': isOnline,
  //   });
  // }
}
