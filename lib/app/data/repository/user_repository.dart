// class UserRepository {
//   final UserProvider _userProvider = UserProvider();

//   Future<User?> me() async {
//     try {
//       final response = await _userProvider.me();
//       return response.user;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<String> updatePassword(String password, String newPassword) async {
//     try {
//       return await _userProvider.updatePassword(password, newPassword);
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<void> updateFcmToken(String fcmToken) async {
//     try {
//       await _userProvider.updateFcmToken(token, fcmToken);
//     } catch (e) {
//       return;
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await storage.erase();
//       await _userProvider.logout();
//     } catch (e) {
//       return;
//     }
//   }

//   Future<String> updateProfile(
//     Map<String, String> body,
//     XFile? img,
//     XFile? imgKtp,
//   ) async {
//     try {
//       return await _userProvider.updateProfile(body, img, imgKtp);
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> cancelVerifikasi() async {
//     try {
//       return await _userProvider.cancelVerifikasi();
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }
