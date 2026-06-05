
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/models/products.dart';
import 'package:shopsphere/services/dummy_apiservices.dart';

final categoryProvider = ChangeNotifierProvider<CategoryProvider>((ref) {
  return CategoryProvider();
});

class CategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _isSelectedCategory = '';

  final DummyApiServices _dummyApiServices = DummyApiServices();

  List<Products> _all = [];
  List<Products> _categoryProducts = [];
  List<Products> _searchResult = [];

  bool get isLoading => _isLoading;

  List<Products> get all => _all;

  String? get errorMessage => _errorMessage;

  List<Products> get categoryProducts => _categoryProducts;

  String? get isSelectedCategory => _isSelectedCategory;

  List<Products> get searchResult => _searchResult;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _setLoading(true);
    _errorMessage = null;

    try {

      _all = await _dummyApiServices.getAllProducts();

      debugPrint('Products loaded: ${_all.length}');
    } catch (e) {
      debugPrint("Load Products Error : $e");

      _setError(
        'Failed to load products. Please check your internet connection',
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<void> category(String category) async {
    _isSelectedCategory = category;

    debugPrint(category);

    _setLoading(true);

    try {
      if (category == "all") {

        _categoryProducts =
        await _dummyApiServices
            .getAllProducts();
        _all=_categoryProducts;
      }
      else {
        _categoryProducts =
        await _dummyApiServices.fetchProductByCategory(category);

        _all = _categoryProducts;
      }
    } catch (e) {
      debugPrint("Category Error : $e");

      _setError(
        'Failed to load products. Please check your internet connection',
      );
    } finally {
      _setLoading(false);
    }
  }

  void sort(String? fucTionName) {
    if (fucTionName == "A To Z") {
      _all.sort((a, b) => a.title.compareTo(b.title));
    } else if (fucTionName == "Default") {
      loadProducts();
    } else if (fucTionName == "Price (High → Low)") {
      _all.sort((a, b) => b.price.compareTo(a.price));
    } else if (fucTionName == "Price (Low → High)") {
      _all.sort((a, b) => a.price.compareTo(b.price));
    }

    notifyListeners();
  }

  Future<void> searchResults(String query) async {
    if (query.isEmpty) {
      _searchResult = [];
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      _searchResult = await _dummyApiServices.searchResult(query);
    } catch (e) {
      debugPrint("Search Error : $e");

    } finally {
      _setLoading(false);
    }
  }

  void clearSearch() {
    _searchResult.clear();
    notifyListeners();
  }
}