String baseUrl = 'http://192.168.100.3/pos/public/';

String imageUrl(String? image) {
  if (image == null || image.isEmpty) {
    return 'https://via.placeholder.com/150';
  }
  return '$baseUrl$image';
}
