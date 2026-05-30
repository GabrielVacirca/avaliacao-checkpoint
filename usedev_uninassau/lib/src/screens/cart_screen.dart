import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/screens/login_screen.dart';
import 'package:usedev_uninassau/src/services/cart_service.dart';
import 'package:usedev_uninassau/src/services/login_service.dart';
import 'package:usedev_uninassau/src/widgets/cart_item_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/custom_app_bar_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> _runCartAction(
    BuildContext context, {
    required Future<void> Function() action,
    String? successMessage,
  }) async {
    try {
      await action();
      if (!context.mounted) return;

      if (successMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(successMessage)));
      }
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível atualizar o carrinho. Tente novamente.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _onCheckout(BuildContext context) async {
    try {
      final hasToken = await LoginService.instance.hasToken();
      if (!context.mounted) return;

      if (!hasToken) {
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Login necessário'),
            content: const Text(
              'Entre na sua conta antes de finalizar a compra.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('CANCELAR'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('ENTRAR'),
              ),
            ],
          ),
        );
        return;
      }

      final cartService = CartScope.of(context);
      await cartService.clearCart();
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra finalizada com sucesso!')),
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível verificar seu login. Tente novamente.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartService = CartScope.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBarWidget(
        cartService: cartService,
        showBackButton: true,
      ),
      body: ListenableBuilder(
        listenable: cartService,
        builder: (context, _) {
          final items = cartService.items;

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Seu carrinho está vazio.\nAdicione produtos para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Meu Carrinho',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.orbitron().fontFamily,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final productId = item.product.id;

                    return CartItemCardWidget(
                      item: item,
                      onIncrement: () => _runCartAction(
                        context,
                        action: () => cartService.incrementQuantity(productId),
                      ),
                      onDecrement: () => _runCartAction(
                        context,
                        action: () => cartService.decrementQuantity(productId),
                      ),
                      onRemove: () => _runCartAction(
                        context,
                        action: () => cartService.removeProduct(productId),
                        successMessage: 'Item removido do carrinho.',
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        Text(
                          _formatCurrency(cartService.totalAmount),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF780BF7),
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _onCheckout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF780BF7),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'FINALIZAR COMPRA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
