import 'package:flutter/material.dart';
import '../models/product.dart';

class CartService {
  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final ValueNotifier<List<CartItem>> cartItems = ValueNotifier<List<CartItem>>([]);
  final ValueNotifier<List<Product>> favoriteItems = ValueNotifier<List<Product>>([]);

  void addToCart(Product product, {int quantity = 1}) {
    final List<CartItem> currentItems = List.from(cartItems.value);
    final int index = currentItems.indexWhere((item) => item.product.name == product.name);

    if (index >= 0) {
      currentItems[index] = CartItem(product: product, quantity: currentItems[index].quantity + quantity);
    } else {
      currentItems.add(CartItem(product: product, quantity: quantity));
    }
    cartItems.value = currentItems;
  }

  void removeFromCart(CartItem item) {
    final List<CartItem> updatedList = List.from(cartItems.value);
    updatedList.removeWhere((i) => i.product.name == item.product.name);
    cartItems.value = updatedList;
  }

  void toggleFavorite(Product product) {
    final List<Product> currentFavs = List.from(favoriteItems.value);
    if (currentFavs.any((p) => p.name == product.name)) {
      currentFavs.removeWhere((p) => p.name == product.name);
    } else {
      currentFavs.add(product);
    }
    favoriteItems.value = currentFavs;
  }

  bool isFavorite(Product product) {
    return favoriteItems.value.any((p) => p.name == product.name);
  }

  void clearCart() {
    cartItems.value = [];
  }

  double getTotalPrice() {
    return cartItems.value.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}

class CartItem {
  final Product product;
  final int quantity;
  CartItem({required this.product, required this.quantity});
}

