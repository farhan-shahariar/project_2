import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewProductInProgresss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write Name of the Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _productCodeTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Product Code',
                    labelText: 'Product Code',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write code of the Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: _unitPriceTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Unit Price',
                    labelText: 'Unit Price',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write Unit Price of the Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: _quantityTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write Quantity of the Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: _totalPriceTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write Total Price of the Product';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _imageTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Image',
                    labelText: 'Image',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Give Image of the Product';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16,),

                Visibility(
                  visible: _addNewProductInProgresss == false,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _addProduct();
                          }
                        },
                        child: const Text('Add')))


              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _addProduct() async {
    _addNewProductInProgresss = true;
    setState(() {});
    const String addProductUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Map<String,dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text,
    };
    Uri uri = Uri.parse(addProductUrl);
    Response response = await post(uri, body: jsonEncode(inputData),
        headers:{'content-type' : 'application/json'}, );
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    _addNewProductInProgresss = false;
    setState(() {});

    if(response.statusCode == 200){
      _nameTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _unitPriceTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New Product added')));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding new product failed. Please try again.'))
      );
    }
  }
  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }
}
