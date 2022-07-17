import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freesmoking/core/logic_func.dart';
import '../models/firebase_exception.dart';

class FirebaseStorage {
  ///
  ///////////   VARIABLES     ////////////////////////////
  UserCredential? _userCredential;
  Stream<User?>? user;

  UserCredential? get userCredential => _userCredential;

  //Using Stream to listen to Authentication State
  Stream<User?>? get authState {
    user = FirebaseAuth.instance.idTokenChanges();
    return user;
  }

  //............ METHODS FOR AUTHENTICATION................

  //SIGN UP METHOD
  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userCredential;
    } on FirebaseException catch (error) {
      throw FirebaseServerException(error.message.toString());
    } catch (error) {
      throw FirebaseServerException(error.toString());
    }
  }

  //SIGN IN METHOD
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      throw FirebaseServerException(e.message.toString());
    }
  }

//Forget password
  forgetPassword(String emailTxt) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailTxt);
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      throw FirebaseServerException(error.toString());
    }
  }

  //............ METHODS FOR ADVICE................

  //GET RANDOM ADVICE
  Future<Map<String, dynamic>> getRandomAdvice(
      {required String collectionName}) async {
    print("============GET RANDOM ADVICE ====================");

    int maxNum = await FirebaseFirestore.instance
        .collection(collectionName)
        .get()
        .then((value) => value.docs.length);

    int number = LogicFunc().randomNumber(maxNumber: maxNum);
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection(collectionName)
        .where("index", isEqualTo: number)
        .get();
    // print(query.docs.length);
    Map<String, dynamic> json =
        query.docs.isNotEmpty ? query.docs[0].data() : {};
    return json;
  }

  // ADD ADVICE
  addAdvice(
      {required String type, required Map<String, dynamic> newAdvice}) async {
    String langAdvice = type.toUpperCase();
    await FirebaseFirestore.instance
        .collection("advice_$langAdvice")
        .add(newAdvice);
  }

  //............ METHODS FOR USER................

  //GET USER DATA
  Future<Map<String, dynamic>?> getUserData() async {
    log("============GET USER DATA ====================");
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> query = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return query.data();
    } else {
      return {};
    }
  }

  //UPDATE USER DATA
  Future<bool> updateUserData(Map<String, dynamic> updateData) async {
    log("============UPDATE DATA  ====================");

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(updateData)
        .then((value) {
      return true;
    });
    return false;
  }

  //SAVE USER DATA
  Future<void> saveUserData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(data['id'])
        .set(data);
  }

//GET COLLECTION DATA
  Future<Map<String, dynamic>?> getCollectionData(String uid) async {
    log("============GET COLLECTION ====================");

    DocumentSnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return query.data();
  }
}
