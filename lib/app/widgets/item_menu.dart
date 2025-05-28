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
        Container(
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl(image)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
              ),
            ),
            Text(
              item,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
