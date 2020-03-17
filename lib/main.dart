import 'package:flutter/material.dart';
import 'package:gpsadmin/Widgets/WMapa.dart';
import 'package:gpsadmin/viewmodels/DeviceViewModel.dart';
import 'package:gpsadmin/viewmodels/auth_view_model.dart';
import 'package:gpsadmin/viewmodels/client_view_model.dart';
import 'package:provider/provider.dart';
import 'Widgets/WMapa.dart';
import 'Views/VLogin.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider<AuthViewModel>(create: (context)=>AuthViewModel()), 
      ChangeNotifierProvider<ClientViewModel>(create: (context)=>ClientViewModel()), 
      ChangeNotifierProvider<DeviceViewModel>(create: (context)=>DeviceViewModel()), 
      ],
                  
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GPS SEGURO',
            home: LoginPage(),
            routes: <String, WidgetBuilder>{
              '/VLogin': (BuildContext context) => new LoginPage(),
              '/VHome': (BuildContext context) => new HomeMapa()
            },
          ));
    
  }
}
