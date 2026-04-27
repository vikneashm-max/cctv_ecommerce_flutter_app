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

  void updateQuantity(CartItem item, int delta) {
    final List<CartItem> currentItems = List.from(cartItems.value);
    final int index = currentItems.indexWhere((i) => i.product.name == item.product.name);

    if (index >= 0) {
      final int newQuantity = currentItems[index].quantity + delta;
      if (newQuantity > 0) {
        currentItems[index] = CartItem(product: item.product, quantity: newQuantity);
      } else {
        currentItems.removeAt(index);
      }
      cartItems.value = currentItems;
    }
  }

  void toggleFavorite(Product product) {
    final List<Product> currentFavs = List.from(favoriteItems.value);
    final int index = currentFavs.indexWhere((p) => p.name == product.name);
    
    if (index >= 0) {
      currentFavs.removeAt(index);
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

  double getSubtotal() {
    return cartItems.value.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}

class CartItem {
  final Product product;
  final int quantity;
  CartItem({required this.product, required this.quantity});
}

