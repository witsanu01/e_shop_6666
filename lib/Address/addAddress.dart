import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            (EcommerceApp.sharedPreferences
                                        .getStringList(
                                            EcommerceApp.userCartList)
                                        .length -
                                    1)
                                .toString(),
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
    );
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding();
  }
}
