import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrderService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> placeOrder(
      List<Map<String, dynamic>> items,
      String paymentMethod,
      double totalPrice,
      ) async {
    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    try {
      List<Map<String, dynamic>> products = [];

      double calculatedTotal = 0;

      for (var data in items) {
        final price =
        (data['price'] ?? 0).toDouble();

        final qty =
        (data['quantity'] ?? 1) as int;

        calculatedTotal += price * qty;

        products.add({
          "name": data['name'],
          "image": data['image'],
          "price": data['price'],
          "quantity": data['quantity'],
        });
      }

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("Orders")
          .add({
        "products": products,
        "paymentMethod": paymentMethod,
        "totalPrice": calculatedTotal,
        "createdAt": Timestamp.now(),
      });

      debugPrint("Order placed successfully");
    } catch (e) {
      debugPrint("Place Order Error : $e");

      throw Exception("Error placing order");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
  getOrderedItems() {
    final userId =
        FirebaseAuth.instance.currentUser!.uid;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Future<void> deleteOrderedProduct(
      String orderId,
      ) async {
    try {
      final userId =
          FirebaseAuth.instance.currentUser!.uid;

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("Orders")
          .doc(orderId)
          .delete();

    } catch (e) {
      debugPrint("Delete Order Error : $e");

    }
  }
}