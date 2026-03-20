import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos_getx/app/style/app_colors.dart';
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
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: const Color(0xff171717),
      border: Border.all(color: const Color(0xff2B2B2B)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: addToCart,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 108,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xff222222),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl(image),
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white38,
                        size: 26,
                      ),
                    ),
                    placeholder: (_, __) => const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (!edit)
              const Icon(
                Icons.add_shopping_cart_rounded,
                size: 16,
                color: Colors.white60,
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (edit)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onTap?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
