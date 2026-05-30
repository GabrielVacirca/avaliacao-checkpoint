import 'package:flutter/widgets.dart';
import 'package:usedev_uninassau/src/models/cart_item_model.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';

class CartService extends ChangeNotifier {
  CartService._();

  static final CartService instance = CartService._();

  final Map<int, CartItemModel> _items = {};

  List<CartItemModel> get items =>
      List.unmodifiable(_items.values.toList(growable: false));

  int get itemCount =>
      _items.values.fold<int>(0, (total, item) => total + item.quantity);

  double get totalAmount => _items.values.fold<double>(
        0,
        (total, item) => total + (item.product.price * item.quantity),
      );

  Future<void> addProduct(ProductModel product) async {
    try {
      final existing = _items[product.id];
      if (existing != null) {
        _items[product.id] = existing.copyWith(
          quantity: existing.quantity + 1,
        );
      } else {
        _items[product.id] = CartItemModel(product: product, quantity: 1);
      }
      notifyListeners();
    } catch (_) {
      throw Exception('Não foi possível adicionar o produto ao carrinho.');
    }
  }

  Future<void> incrementQuantity(int productId) async {
    try {
      final existing = _items[productId];
      if (existing == null) {
        throw Exception('Produto não encontrado no carrinho.');
      }
      _items[productId] = existing.copyWith(quantity: existing.quantity + 1);
      notifyListeners();
    } catch (_) {
      throw Exception('Não foi possível aumentar a quantidade.');
    }
  }

  Future<void> decrementQuantity(int productId) async {
    try {
      final existing = _items[productId];
      if (existing == null) {
        throw Exception('Produto não encontrado no carrinho.');
      }
      if (existing.quantity <= 1) {
        _items.remove(productId);
      } else {
        _items[productId] =
            existing.copyWith(quantity: existing.quantity - 1);
      }
      notifyListeners();
    } catch (_) {
      throw Exception('Não foi possível diminuir a quantidade.');
    }
  }

  Future<void> removeProduct(int productId) async {
    try {
      if (!_items.containsKey(productId)) {
        throw Exception('Produto não encontrado no carrinho.');
      }
      _items.remove(productId);
      notifyListeners();
    } catch (_) {
      throw Exception('Não foi possível remover o produto do carrinho.');
    }
  }

  Future<void> clearCart() async {
    try {
      _items.clear();
      notifyListeners();
    } catch (_) {
      throw Exception('Não foi possível limpar o carrinho.');
    }
  }
}

class CartScope extends InheritedNotifier<CartService> {
  const CartScope({
    required CartService super.notifier,
    required super.child,
    super.key,
  });

  static CartService of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope não encontrado na árvore de widgets.');
    return scope!.notifier!;
  }
}
