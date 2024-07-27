import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingpos/screens/home/widgets/order_list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> orderList = [];
  List<Color> colors = [Colors.green, Colors.orangeAccent, Colors.blue, Colors.green, Colors.red];
  List<String> texts = ['Complete', 'Progress', 'Pending',"Complete", 'Cancelled'];
  int temp = 0;
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    getOrderList();
    //getAllProducts();
  }

  Future<void> getAllProducts() async{
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if(response.statusCode == 200 || response.statusCode == 201) {

    }else{
      print("Failed to get products");
    }
  }

  //get order list items
  Future<void> getOrderList() async{
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=5"));
    if(response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      for(var data in decodedData){
        setState(() {
          orderList.add(data);
        });
      }
      setState(() {
        isFetching = false;
      });
    }else{
      print("Failed to get products");
    }
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset('images/man.png'),
          title: Text(
              "Hello, Jhon",
              style: TextStyle(
                  color: Colors.white
              )
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.search_sharp)
              ),
              color: Colors.white
            ),
            IconButton(
                onPressed: (){},
                icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.shopping_cart_outlined)
                ),
                color: Colors.white
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: isFetching
              ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              )
          )
              : Column(
            children: [
              //top section
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      //order list
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                                'Order List',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                )
                            ),
                            Text(
                                'See All',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 15
                                )
                            ),
                          ],
                        ),
                      ),
                      //order list items
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < orderList.length; i++)
                              OrderListCard(
                                color: colors[i % colors.length],
                                height: height,
                                order: orderList[i],
                                cardType: texts[i % texts.length],
                              )
                          ],
                        ),
                      )
                    ],
                  )
              ),
              //food item section
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}
