import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  final List<String> products;
  const ProductsPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(title: Text(product));
        },
      ),
    );
  }
}
