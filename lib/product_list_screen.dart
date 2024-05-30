import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_2/add_product_screen.dart';
import 'package:project_2/update_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (_, __) {
              return const Divider();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return ListTile(
      //leading: Image.network(''),
      title:  Text(product.productName),
      subtitle:  Wrap(
        spacing: 10,
        children: [
          Text('Unit Price: ${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: ${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(
        spacing: 16,
        children: [
          IconButton(
              onPressed: () async{
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  UpdateProductScreen(product: product,)));
                if(result == true){
                  _getProductList();
                }
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(product.id);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }

  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    const String getProductListUrl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(getProductListUrl);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final jsonProductList = decodedData['data'];
      for(Map<String, dynamic> p in jsonProductList){
        Product product = Product(id: p['_id'] ?? 'Unknown',
            productName: p['ProductName'] ?? 'Unknown',
            productCode: p['ProductCode'] ?? 'Unknown',
            image: p['Img'] ?? 'Unknown',
            unitPrice: p['UnitPrice'] ?? 'Unknown',
            quantity: p['Qty'] ?? 'Unknown',
            totalPrice: p['TotalPrice'] ?? 'Unknown',);

        productList.add(product);

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Get product list failed. Please try again.')));
    }

    _getProductListInProgress = false;
    setState(() {});
  }

  Future<void> _deleteProductList(String productId) async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();
    String deleteProductListUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${productId}';
    Uri uri = Uri.parse(deleteProductListUrl);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Get product list failed. Please try again.')));
    }
  }

  void _showDeleteConfirmationDialog(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            content:
                const Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
              TextButton(onPressed: () {
                _deleteProductList(productId);
                Navigator.pop(context);
              },
                  child: const Text('Yes, delete'))
            ],
          );
        });
  }
}

class Product {
  final String id;
  final String productName;
  final String productCode;
  final String image;
  final String unitPrice;
  final String quantity;
  final String totalPrice;


  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.image,
      required this.unitPrice,
      required this.quantity,
      required this.totalPrice,
      });
}
