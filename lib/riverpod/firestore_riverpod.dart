import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/services/firestore_services.dart';
import 'package:shopsphere/services/order_service.dart';

final firestoreProvider = ChangeNotifierProvider<FirestoreProvider>((ref) {
  return FirestoreProvider();
});

class FirestoreProvider extends ChangeNotifier {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final FirestoreServices _firestoreServices = FirestoreServices();
  final OrderService _orderService = OrderService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addToCart(Map<String, dynamic> products, int quantity) async {
    try {
      _setLoading(true);

      await _firestoreServices.addToCart(userId, products, quantity);

      notifyListeners();
    } catch (e) {
      debugPrint('Add To Cart Error : $e');
    } finally {
      _setLoading(false);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCartItems() {
    try {
      return _firestoreServices.getCartItems();
    } catch (e) {
      debugPrint('Get Cart Items Error : $e');
      return Stream.empty();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAccountDetails() {

    try {
      return _firestoreServices.getAccountDetails();
    } catch (e) {
      debugPrint('Account Details Error : $e');
      return Stream.empty();
    }
  }

  Future<void> deleteItems(String productID) async {
    try {
      _setLoading(true);

      await _firestoreServices.deleteItems(productID);

      notifyListeners();
    } catch (e) {
      debugPrint("Delete Item Error : $e");
    } finally {
      _setLoading(false);
    }
  }

  Stream<bool> isItemInCart(String productId) {
    try {
      return _firestoreServices.isItemInCart(productId);
    } catch (e) {
      debugPrint("Check Cart Error : $e");
      return Stream.value(false);
    }
  }

  Future<void> saveAddress(Map<String, dynamic> addresses) async {
    try {
      _setLoading(true);

      await _firestoreServices.saveAddress(addresses);

      notifyListeners();
    } catch (e) {
      debugPrint("Save Address Error : $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> upDateAddress(String docId, Map<String, dynamic> data) async {
    try {
      _setLoading(true);

      await _firestoreServices.upDateAddress(docId, data);

      notifyListeners();
    } catch (e) {
      debugPrint('Update Address Error : $e');
    } finally {
      _setLoading(false);
    }
  }

  Stream<int> getCartCount() {
    try {
      return _firestoreServices.getCartCount();
    } catch (e) {
      debugPrint("Cart Count Error : $e");
      return Stream.value(0);
    }
  }

  Future<void> placeAnOrder(
    List<Map<String, dynamic>> items,
    String paymentMethod,
    double totalPrice,
  ) async {
    try {
      _setLoading(true);

      await _orderService.placeOrder(items, paymentMethod, totalPrice);

      notifyListeners();
    } catch (e) {
      debugPrint('Place Order Error : $e');
      throw Exception("Order error");
    } finally {
      _setLoading(false);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrderedItems() {
    try {
      return _orderService.getOrderedItems();
    } catch (e) {
      debugPrint('Get Orders Error : $e');
      return Stream.empty();
    }
  }

  Future<void> deleteOrderedProduct(String orderID) async {
    try {
      _setLoading(true);

      await _orderService.deleteOrderedProduct(orderID);

      notifyListeners();
    } catch (e) {
      debugPrint("Delete Ordered Product Error : $e");
    } finally {
      _setLoading(false);
    }
  }
}
