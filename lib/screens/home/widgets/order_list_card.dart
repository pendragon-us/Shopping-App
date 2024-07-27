import 'package:flutter/material.dart';

class OrderListCard extends StatelessWidget {

  final Color color;
  final double height;
  final dynamic order;
  final String cardType;

  const OrderListCard({
    super.key,
    required this.color,
    required this.height,
    required this.order,
    required this.cardType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: height * 0.16,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //title and rate
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                (order['title'].split(' ').length > 2
                    ? order['title'].split(' ').take(2).join(' ') + '...'
                    : order['title']),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'
                ),
              ),
              //rate and count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //count
                  Text(
                    'Count ${order['rating']['count'].toString()}',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),
                  ),

                  Icon(Icons.circle, size: 10, color: Colors.black38),

                  //rating
                  Text(
                    'Rate ${order['rating']['rate'].toString()}',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'
                    ),
                  )
                ],
              ),
            ],
          ),
          //description
          Text(
            (order['description'].split(' ').length > 2
                ? order['description'].split(' ').take(2).join(' ') + '...'
                : order['description']),
            style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
            ),
          ),
          //complete card
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              cardType,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
              ),
            ),
          )
        ],
      ),
    );
  }
}
