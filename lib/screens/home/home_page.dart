import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:shoppingpos/screens/home/widgets/menu_card.dart';
import 'package:shoppingpos/screens/home/widgets/order_list_card.dart';

import '../../models/shopping_cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  List<Color> colors = [Colors.green, Colors.orangeAccent, Colors.blue, Colors.green, Colors.red];
  List<String> texts = ['Complete', 'Progress', 'Pending', "Complete", 'Cancelled'];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShoppingCartProvider>().getAllProducts();
      context.read<ShoppingCartProvider>().getOrderList();
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: LiquidPullToRefresh(
        color: Colors.white,
        backgroundColor: Colors.black,
        onRefresh: context.read<ShoppingCartProvider>().getOrderList,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('images/man.png'),
            ),
            title: Text(
              "Hello, Jhon",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.search_sharp),
                ),
                color: Colors.white,
              ),
              Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    color: Colors.white,
                  ),
                  if(context.watch<ShoppingCartProvider>().itemsInCart > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: context.watch<ShoppingCartProvider>().isFetching
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
            )
                : Column(
              children: [
                // Top section
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Order list
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Order List',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'See All',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Order list items
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < context.watch<ShoppingCartProvider>().orderList.length; i++)
                              OrderListCard(
                                color: colors[i % colors.length],
                                height: height,
                                order: context.watch<ShoppingCartProvider>().orderList[i],
                                cardType: texts[i % texts.length],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Food item section
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Tab view and items
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tab view
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              width: MediaQuery.of(context).size.width,
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabs: const [
                                  Tab(
                                    text: 'For You',
                                  ),
                                  Tab(
                                    text: 'Saved',
                                  ),
                                ],
                              ),
                            ),
                            // Select menu
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Select Menu",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Item cards
                            Expanded(
                              child: GridView.builder(
                                itemCount: context.watch<ShoppingCartProvider>().allProducts.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return MenuCard(
                                    image: Image.network(
                                      context.watch<ShoppingCartProvider>().allProducts[index]['image'],
                                      width: 100,
                                      height: 100,
                                    ),
                                    title: context.watch<ShoppingCartProvider>().allProducts[index]['title'],
                                    description: context.watch<ShoppingCartProvider>().allProducts[index]['description'],
                                    rate: context.watch<ShoppingCartProvider>().allProducts[index]['rating']['rate'].toString(),
                                    price: context.watch<ShoppingCartProvider>().allProducts[index]['price'].toString(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        //total
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  //icon
                                  Icon(Icons.shopping_bag_outlined, color: Colors.white),
                                  SizedBox(width: 10),
                                  //total
                                  Text(
                                    "Rs. ${context.watch<ShoppingCartProvider>().totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  //item count
                                  Text(
                                    "${context.watch<ShoppingCartProvider>().itemsInCart} items",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              //process transaction
                              Text(
                                "Process",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
