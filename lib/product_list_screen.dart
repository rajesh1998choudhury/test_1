// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:test_1/provider.dart';

// // class ProductListScreen extends StatelessWidget {
// //   const ProductListScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Product List')),
// //       body: FutureBuilder(
// //         future: Provider.of<AuthProvider>(context, listen: false)
// //             .fetchProductList(),
// //         builder: (ctx, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else {
// //             return Consumer<AuthProvider>(
// //               builder: (ctx, authProvider, child) {
// //                 final productList = authProvider.productList;

// // ignore_for_file: library_private_types_in_public_api

// //                 if (productList.isEmpty) {
// //                   return const Center(child: Text('No products available.'));
// //                 } else {
// //                   return ListView.builder(
// //                     itemCount: productList.length,
// //                     itemBuilder: (ctx, index) {
// //                       final product = productList[index];
// //                       return ListTile(
// //                         title: Text(product.name ?? ''),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text('MOQ: ${product.moq ?? ''}'),
// //                             Text('Price: ${product.price ?? ''}'),
// //                             Text(
// //                                 'Discounted Price: ${product.discountedPrice ?? ''}'),
// //                           ],
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 }
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_1/provider.dart';

// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});

//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final _idController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _moqController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _discountedPriceController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<AuthProvider>(context, listen: false).fetchProductList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final products = Provider.of<AuthProvider>(context).products;

// ignore_for_file: library_private_types_in_public_api

//     return Scaffold(
//       appBar: AppBar(title: const Text('Products')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   final product = products[index];
//                   return ListTile(
//                     title: Text(product.name ?? ''),
//                     subtitle:
//                         Text('Price: ${product.price}, MOQ: ${product.moq}'),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _idController,
//               decoration: const InputDecoration(labelText: 'Product ID'),
//             ),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name'),
//             ),
//             TextField(
//               controller: _moqController,
//               decoration: const InputDecoration(labelText: 'MOQ'),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: const InputDecoration(labelText: 'Price'),
//             ),
//             TextField(
//               controller: _discountedPriceController,
//               decoration: const InputDecoration(labelText: 'Discounted Price'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Provider.of<AuthProvider>(context, listen: false)
//                     .addProduct(
//                   _idController.text,
//                   _nameController.text,
//                   _moqController.text,
//                   _priceController.text,
//                   _discountedPriceController.text,
//                 )
//                     .then((_) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Product added successfully!')),
//                   );
//                 }).catchError((error) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Error: $error')),
//                   );
//                 });
//               },
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _moqController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the product name';
                  return null;
                },
              ),
              TextFormField(
                controller: _moqController,
                decoration: const InputDecoration(
                    labelText: 'Minimum Order Quantity (MOQ)'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the MOQ';
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the price';
                  return null;
                },
              ),
              TextFormField(
                controller: _discountPriceController,
                decoration: const InputDecoration(labelText: 'Discount Price'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the discount price';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .addProduct(
                      _nameController.text,
                      _moqController.text,
                      _priceController.text,
                      _discountPriceController.text,
                    )
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Product created successfully')),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())),
                      );
                    });
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
