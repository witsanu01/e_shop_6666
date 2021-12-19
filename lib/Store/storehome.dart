import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blueAccent, Colors.black12],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 0.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "82 Cafe",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                ),
                Positioned(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.green,
                      ),
                      Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        left: 3.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text(
                              counter.count.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SearchBoxDelegate(),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Item")
                  .limit(15)
                  .orderBy("publishedData", descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.documents.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    // onTap: () {
    //   Route route = MaterialPageRoute(
    //     builder: (c) => ProductPage(
    //       itemModel: model,
    //     ),
    //   );
    //   Navigator.pushReplacement(context, route);
    // },
    splashColor: Colors.blue,
    child: Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: 150.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.thumbnailUrl,
              width: 150.0,
              height: 150.0,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          model.title,
                          style: TextStyle(color: Colors.blue, fontSize: 15.0),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          model.shortInfo,
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.blue),
                        alignment: Alignment.topLeft,
                        width: 40.0,
                        height: 43.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "50%",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "off",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  "Original Price ฿",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text(
                                  (model.price + model.price).toString(),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  "New Price: ",
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.grey),
                                ),
                                Text(
                                  " ฿",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16.0),
                                ),
                                Text(
                                  (model.price).toString(),
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: removeCartFunction == null
                        ? IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.greenAccent,
                            ),
                            onPressed: () {
                              checkItemInCart(model.shortInfo, context);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                  ),
                  Divider(
                    height: 5.0,
                    color: Colors.greenAccent,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.greenAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String shortInfoAsID, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(shortInfoAsID)
      ? Fluttertoast.showToast(msg: "Item is already in Cart")
      : addItemToCart(shortInfoAsID, context);
}

addItemToCart(String shortInfoAsID, BuildContext context) {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsID);
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({EcommerceApp.userCartList: tempCartList}).then((v) {
    Fluttertoast.showToast(msg: "Item Added to Cart Successfully");

    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
