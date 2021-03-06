import 'package:flutter/material.dart';
import 'package:sqflite_app/data/dbHelper.dart';
import 'package:sqflite_app/models/product.dart';
import 'package:sqflite_app/screens/product_add.dart';
import 'package:sqflite_app/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }
}

class ProductListState extends State {
  var dbHelper = DbHelper();
  List<Product> productList;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürünler Listesi"),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => gotoProductAdd(),
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildBody() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text("P"),
              ),
              title: Text(this.productList[position].name),
              subtitle: Text(this.productList[position].description),
              onTap: () => gotoProductDetail(this.productList[position]),
            ),
          );
        });
  }

  void getProducts() async {
    var productFuture = dbHelper.getProducts();
    productFuture.then((data) {
      setState(() {
        this.productList = data;
        productCount = data.length;
      });
    });
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        this.context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (bool != null) {
      if (result == true) getProducts();
    }
  }

  void gotoProductDetail(Product product) async {
    bool result = await Navigator.push(this.context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (bool != null) {
      if (result == true) getProducts();
    }
  }
}
