import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../../core/typedefs.dart';
import '../../../models/user_model.dart';

final currentUserProvider = FutureProvider((ref) async {
  final authRepo = ref.watch(authRepositoryProvider);
  return authRepo.getCurrentUser();
});

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: ref.read(authProvider),
    firestore: ref.read(fireStoreProvider),
    googleSignIn: ref.read(googleSignInProvider)));

final authStateChangeProvider = StreamProvider((ref) {
  final auth = ref.watch(authProvider);
  return auth.authStateChanges();
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users => _firestore.collection('users');

  Stream<User?> get authStateChanged => _auth.authStateChanges();

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleSignIn = (await googleUser?.authentication);
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignIn?.accessToken,
        idToken: googleSignIn?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? '',
          profilePic: userCredential.user!.photoURL ?? '',
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          budget: 0,
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData().first;
      }
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData() {
    return _users.doc(_auth.currentUser!.uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  // UserModel getCurrentUser() {
  //   return _auth.currentUser
  // }

  Future<UserModel> getCurrentUser() async {
    final userDataMap = await _users.doc(_auth.currentUser!.uid).get();
    return UserModel.fromMap(userDataMap.data() as Map<String, dynamic>);
  }

  FutureVoid googleSignOut() async {
    try {
      return right(await _auth.signOut());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
