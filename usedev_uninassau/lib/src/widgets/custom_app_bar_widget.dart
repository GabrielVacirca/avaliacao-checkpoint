import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/screens/login_screen.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    required this.cartService,
    this.showBackButton = false,
    super.key,
  });

  final CartService cartService;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 32),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : const Icon(Icons.menu, size: 40),
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, size: 36),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => LoginScreen()),
            );
          },
        ),
        ListenableBuilder(
          listenable: cartService,
          builder: (context, _) {
            final count = cartService.itemCount;
            return IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: Badge(
                isLabelVisible: count > 0,
                backgroundColor: const Color(0xFF780BF7),
                label: Text('$count'),
                child: const Icon(Icons.shopping_cart_outlined, size: 40),
              ),
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
