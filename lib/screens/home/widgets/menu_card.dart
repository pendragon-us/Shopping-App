
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/shopping_cart_provider.dart';

class MenuCard extends StatefulWidget {
  final Image image;
  final String title;
  final String description;
  final String rate;
  final String price;

  MenuCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rate,
    required this.price,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isFavorite = false;
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSelect = !isSelect;
            });
            context.read<ShoppingCartProvider>().addItemToCart({
              'title': widget.title,
              'description': widget.description,
              'rate': widget.rate,
              'price': widget.price,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 400),
                backgroundColor: Colors.green,
                content: Text('Added to cart!'),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: widget.image,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.title.split(' ').length > 3
                        ? '${widget.title.split(' ').take(3).join(' ')} ...'
                        : widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    widget.description.split(' ').length > 10
                        ? '${widget.description.split(' ').take(20).join(' ')}...'
                        : widget.description,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //rate
                      Text(
                        "⭐️ ${widget.rate}",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),

                      //price
                      Text(
                        "Rs.${widget.price}/=",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
            if(isFavorite) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 400),
                  backgroundColor: Colors.pink,
                  content: Text('Added to Favourites!'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 400),
                  backgroundColor: Colors.redAccent,
                  content: Text('Removed from Favourites!'),
                ),
              );
            }
          },
          child: Container(
              margin: const EdgeInsets.only(right: 10, top: 10),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border, size: 20,
                color: isFavorite ? Colors.red : Colors.grey,
              )
          ),
        ),
      ],
    );
  }
}
