String baseUrl = 'http://173.103.11.5/pos/public/';

String imageUrl(String? image) {
  if (image == null || image.isEmpty) {
    return 'https://via.placeholder.com/150';
  }
  return '$baseUrl$image';
}
