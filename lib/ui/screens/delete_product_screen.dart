import 'package:assaignment/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DeleteProductScreen extends StatefulWidget {
  const DeleteProductScreen({super.key, required this.product});

  static const String name = '/delete-product';

  final Product product;

  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  bool _deleteProductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildDeleteConfirmation(),
      ),
    );
  }

  Widget _buildDeleteConfirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.delete_forever,
          size: 80,
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        Text(
          'Are you sure you want to delete "${widget.product.productName}"?',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Visibility(
          visible: _deleteProductInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _deleteProduct();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _deleteProduct() async {
    _deleteProductInProgress = true;
    setState(() {});

    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}');

    Response response = await get(uri); // Delete API Call
    print(response.statusCode);
    print(response.body);

    _deleteProductInProgress = false;
    setState(() {});

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product has been deleted successfully!'),
        ),
      );
      Navigator.pop(context, true); // Return true to indicate deletion success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete the product! Try again.'),
        ),
      );
    }
  }
}
