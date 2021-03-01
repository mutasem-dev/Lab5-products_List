import 'package:flutter/material.dart';
import 'package:products_list_example/product.dart';
import 'package:toast/toast.dart';
class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Text('Product Information',
            style: TextStyle(
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              fontSize: 25.0
            ),
          ),

          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Product Name'
            ),
          ),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Quantity'
            ),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Price'
            ),
          ),
          RaisedButton.icon(
              onPressed: () {
                if(nameController.text.isEmpty ||
                quantityController.text.isEmpty ||
                priceController.text.isEmpty) {
                  Toast.show('please fill all fields', context);
                  return;
                }
                int q;
                try {
                  q = int.parse(quantityController.text);
                } catch(e) {
                  Toast.show('enter a valid integer', context);
                  return;
                }

                setState(() {
                  Product p = Product(
                    productName: nameController.text,
                    quantity: q,
                    price: double.parse(priceController.text)
                  );
                  products.add(p);
                  nameController.clear();
                  quantityController.clear();
                  priceController.clear();
                });
              },
              icon: Icon(Icons.add),
              label: Text('add product'),
          ),
          Text('Your Products',
              style: TextStyle(
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              fontSize: 25.0
          ),
          ),
          SizedBox(height: 8.0,),
          Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue,
                      leading: Text(products[index].productName,
                          style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0
                      ),
                      ),
                      title: Text('Price: ${products[index].price}'),
                      subtitle: Text('Quantity: ${products[index].quantity}'),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}
