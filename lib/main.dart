import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gpsadmin/Views/Vsplash.dart';
import 'package:gpsadmin/Widgets/WMapa.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:gpsadmin/viewmodels/DeviceViewModel.dart';
import 'package:gpsadmin/viewmodels/auth_view_model.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:provider/provider.dart';
import 'Views/VLogin.dart';
import 'Widgets/WMapa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(LoginApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message: ${message.messageId}');
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthViewModel>(
              create: (context) => AuthViewModel()),
          ChangeNotifierProvider<ClientViewModel>(
              create: (context) => ClientViewModel()),
          ChangeNotifierProvider<DeviceViewModel>(
              create: (context) => DeviceViewModel()),
          ChangeNotifierProvider(create: (context) => LoginBloc()..init()..gettoken()
          ..callapi())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: const Color(0xff40B5C1)),
          title: 'GPS ASEGURO',
          home: VSplash(),
          routes: <String, WidgetBuilder>{
            'VLogin': (BuildContext context) => LoginPage(),
            'VHome': (BuildContext context) => HomeMapa(),
            'myapp': (BuildContext context) => LoginApp(),
          },
        ));
  }
}
