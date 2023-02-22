import 'package:flutter/cupertino.dart';
import 'package:gpsadmin/models/notification.dart';
import 'package:gpsadmin/services/endpoint.dart';

class NotificationBloc extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool load) {
    _loading = load;
    notifyListeners();
  }

  List<Notifications> notifications = [];

  Future getnotification() async {
    notifications = await Apis().listNotifications('');
  }
}
