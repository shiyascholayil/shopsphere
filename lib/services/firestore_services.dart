import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addToCart(
      String userId,
      Map<String, dynamic> products,
      int quantity,
      ) async {
    try {
      final ref = _firestore
          .collection("users")
          .doc(userId)
          .collection('cart')
          .doc(products['id'].toString());

      await ref.set({
        'id': products['id'].toString(),
        'name': products['name'],
        'price': products['price'],
        'image': products['image'],
        'category': products['category'] ?? '',
        'description':
        products['description'] ?? '',
        'rate': products['rate'] ?? 0,
        'reviews': products['reviews'] ?? [],
        'quantity': quantity,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Add To Cart Error : $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
  getCartItems() {
    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .snapshots();
  }

  Future<void> deleteItems(String productId) async {
    try {
      final userId =
          FirebaseAuth.instance.currentUser!.uid;

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc(productId)
          .delete();
    } catch (e) {
      debugPrint("Delete Item Error : $e");
      rethrow;
    }
  }

  Stream<bool> isItemInCart(String productId) {
    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection("cart")
          .doc(productId)
          .snapshots()
          .map((doc) => doc.exists);
    } catch (e) {
      debugPrint("Check Cart Error : $e");

      return Stream.value(false);
    }
  }

  Future<void> saveAddress(
      Map<String, dynamic> addresses,
      ) async {
    try {
      final userId =
          FirebaseAuth.instance.currentUser!.uid;

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("addresses")
          .add(addresses);
    } catch (e) {
      debugPrint("Save Address Error : $e");
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
  getAccountDetails() {

    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("addresses")
        .snapshots();
  }

  Future<void> upDateAddress(
      String docId,
      Map<String, dynamic> data,
      ) async {
    try {
      final userId =
          FirebaseAuth.instance.currentUser!.uid;

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("addresses")
          .doc(docId)
          .update(data);
    } catch (e) {
      debugPrint("Update Address Error : $e");
      rethrow;
    }
  }

  Stream<int> getCartCount() {
    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .snapshots()
        .map(
          (snapshots) => snapshots.docs.length,
    );
  }
}