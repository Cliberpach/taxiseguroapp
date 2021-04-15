import 'package:flutter/material.dart';
import 'package:gpsadmin/bloc/loginbloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class WNotification extends StatelessWidget {
  const WNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Notificaciones'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<LoginBloc>(builder: (context, bloc, widget) {
          return bloc.loadingnoti == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: bloc.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.orange,
                                  radius: 20,
                                  child:
                                      Icon(MdiIcons.alert, color: Colors.white),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(bloc.notifications[index].informacion,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 20),
                                    Text(
                                        bloc.notifications[index].creado
                                            .toString(),
                                        style: const TextStyle(fontSize: 11)),
                                  ],
                                )
                              ],
                            )));
                  },
                );
        }),
      ),
    );
  }
}
