String baseUrl = 'https://outsidecoffee.id/';

String imageUrl(String? image) {
  if (image == null || image.isEmpty) {
    return 'https://via.placeholder.com/150';
  }
  return '$baseUrl$image';
}
