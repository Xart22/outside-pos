// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pos_getx/app/data/repository/user_repository.dart';

// class UserService extends GetxService {
//   final storage = GetStorage();
//   final UserRepository _userRepository = UserRepository();

//   bool get isLoggedIn => storage.hasData('auth_token');

//   String get token => storage.read('auth_token');

//   User get user => User.fromJson(storage.read('user'));

//   void saveUser(User user) async {
//     await storage.write('user', user);
//   }

//   void saveToken(String token) {
//     storage.write('auth_token', token);
//   }

//   void removeToken() {
//     storage.remove('auth_token');
//   }

//   Future<User?> me() async {
//     if (!isLoggedIn) return null;
//     try {
//       final response = await _userProvider.me(token);
//       storage.write('user', response.user.toJson());
//       return response.user;
//     } catch (e) {
//       return null;
//     }
//   }

//   //update fcm token
//   Future<void> updateFcmToken(String fcmToken) async {
//     try {
//       await _userProvider.updateFcmToken(token, fcmToken);
//     } catch (e) {
//       return;
//     }
//   }

//   // update location
//   Future<void> updateLocation(double latitude, double longitude) async {
//     try {
//       await _userProvider.updateLocation(token, latitude, longitude);
//     } catch (e) {
//       return;
//     }
//   }

//   // logout
//   Future<void> logout() async {
//     try {
//       await storage.erase();
//       await _userProvider.logout(token);
//     } catch (e) {
//       return;
//     }
//   }
// }
