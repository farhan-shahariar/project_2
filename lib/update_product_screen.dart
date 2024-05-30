import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_2/product_list_screen.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    _productCodeTEController.text = widget.product.productCode;
    _nameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _quantityTEController.text = widget.product.quantity;
    _totalPriceTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.image;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
                  controller: _productCodeTEController,
                  decoration:  const InputDecoration(
                    hintText: 'Product Code',
                    labelText: 'Product Code',
                  ),
                  validator: (String ? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write Name of the Product code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),

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
                  visible: _updateProductInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _updateProduct();
                        }
                      },
                      child: const Text('Update')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async{
    _updateProductInProgress = true;
    setState(() {});

    Map<String,String> inputData =
    {
      "Img": _imageTEController.text,
    "ProductCode": _productCodeTEController.text,
    "ProductName": _nameTEController.text,
    "Qty": _quantityTEController.text,
    "TotalPrice": _totalPriceTEController.text,
    "UnitPrice": _unitPriceTEController.text,
    };
    String updateProductUrl = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri, headers: {'content-type' : 'application/json'}, body: jsonEncode(inputData));
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The product has been updated.'))
      );
      Navigator.pop(context, true);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product can not be updated. Please try again.'))
      );

    }

  }

  @override
  void dispose() {
    _productCodeTEController.dispose();
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }

}
