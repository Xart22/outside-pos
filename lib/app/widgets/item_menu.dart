import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_getx/app/utils/url_image.dart';

Widget itemMenu({
  required String image,
  required String title,
  required String price,
  required String item,
  required bool edit,
  Function()? onTap,
  Function()? addToCart,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: const Color(0xff1A1A1A),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: addToCart,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl(image)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 12,
              ),
            ),
            Text(
              item,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (edit)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onTap?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    ),
  );
}
