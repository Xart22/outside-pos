import 'package:router_os_client/router_os_client.dart';

late RouterOSClient client;
Future<void> connectToRouter() async {
  try {
    client = RouterOSClient(
      address: "173.13.0.1",
      user: "admin",
      password: "OutSid3",
      port: 8728,
      useSsl: false,
      timeout: const Duration(seconds: 10),
      verbose: true,
    );

    bool loginSuccess = await client.login();
    if (loginSuccess) {
      print('Login successful');
    } else {
      print('Login failed');
    }
  } catch (e) {
    print('Error connecting to router: $e');
  }
}

Future<void> createHotspotUser(String username, String password,
    {String profile = 'default'}) async {
  await connectToRouter();
  final command = [
    '/ip/hotspot/user/add',
    '=name=$username',
    '=password=$password',
    '=profile=$profile',
    '=limit-uptime=3h',
  ];

  await client.talk(command);
  client.close();
}
