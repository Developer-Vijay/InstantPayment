import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/SplashScreen/splashScreen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(Netly());
}

class Netly extends StatefulWidget {
  @override
  _NetlyState createState() => _NetlyState();
}

class _NetlyState extends State<Netly> {
  IO.Socket socket;
  @override
  void initState() {
    super.initState();
  }
  void connect() {
    socket = IO.io("https://intense-lowlands-63563.herokuapp.com", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
       'extraHeaders': {'Connection': 'Upgrade', 'Upgrade': 'websocket'},
      "verify": true
    });
    socket.connect();
    socket.onError((err) {
      print("???????????");
      print(err);
      print("???????????");
    });
    socket.onConnectError((err) {
      print("/////");
      print(err);
      print("////////");
    });

    socket.onConnect((data) {
      print(
        "Connected....hurrey",
      );
      print("///////");
      print(socket.id);
      print("///////");
    });
    print(socket.connected);
    socket.emit("/test", "Hello World");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: ("Netpayment"),
                theme: ThemeData(
                    fontFamily: 'PT Serif', primarySwatch: Colors.blue),
                home: SplashPage());
          },
        );
      },
    );
  }
}
