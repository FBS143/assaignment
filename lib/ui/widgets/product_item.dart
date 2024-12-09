import 'package:assaignment/models/product.dart';
import 'package:assaignment/ui/screens/delete_product_screen.dart';
import 'package:assaignment/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image != null && product.image!.isNotEmpty
            ? product.image!
            : 'https://via.placeholder.com/150', // Default placeholder image
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 40);
        },
      ),
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${product.quantity ?? 'Unknown'}'),
          Text('Price: ${product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${product.totalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                DeleteProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
