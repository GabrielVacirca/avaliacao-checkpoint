import 'package:flutter_test/flutter_test.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/models/rating_model.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

void main() {
  final cartService = CartService.instance;
  const product = ProductModel(
    id: 1,
    title: 'Produto de teste',
    price: 10,
    description: 'Descrição de teste',
    category: 'teste',
    image: '',
    rating: RatingModel(rate: 5, count: 1),
  );

  Future<void> clearCart() async {
    for (final item in cartService.items) {
      await cartService.removeProduct(item.product.id);
    }
  }

  setUp(clearCart);
  tearDown(clearCart);

  test('CartService keeps a single instance', () {
    expect(identical(CartService.instance, CartService.instance), isTrue);
  });

  test('cart updates quantity, total and listeners', () async {
    var notificationCount = 0;
    void listener() => notificationCount++;

    cartService.addListener(listener);
    addTearDown(() => cartService.removeListener(listener));

    await cartService.addProduct(product);
    await cartService.incrementQuantity(product.id);

    expect(cartService.itemCount, 2);
    expect(cartService.totalAmount, 20);

    await cartService.decrementQuantity(product.id);
    expect(cartService.itemCount, 1);

    await cartService.removeProduct(product.id);
    expect(cartService.items, isEmpty);
    expect(notificationCount, 4);
  });

  test('cart is cleared after checkout action', () async {
    await cartService.addProduct(product);
    await cartService.clearCart();

    expect(cartService.items, isEmpty);
    expect(cartService.itemCount, 0);
    expect(cartService.totalAmount, 0);
  });
}
