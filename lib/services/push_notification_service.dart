import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
// SHA1: A4:E0:B2:6E:06:72:73:E5:20:DA:7A:BB:78:93:B9:3B:85:A5:FD:8A

//class for manage push on firebase
class PushNotificationService {
  static FirebaseMessaging messaging =
      FirebaseMessaging.instance; //info firebase
  static String? token;
  //emitir msj (string)
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  //definir msj
  static Stream<String> get messageStream =>
      _messageStream.stream; //for suscribe

  //in the home fron phone
  static Future _backgroundHandler(RemoteMessage message) async {
    //print('background Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body ?? 'No data');
    //_messageStream.add(message.data['product'] ?? 'No data');
  }

  //in the app
  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body ?? 'No data');
    //_messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('onMessageOpenApp Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body ?? 'No data');
    //_messageStream.add(message.data['product'] ?? 'No data');
  }

  //inicialice a app service and generarte token
  static Future initializeApp() async {
    //push notification
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('token: $token'); //print token of device

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //Local notification
  }

  //close stream for quit warning
  static closeStream() {
    _messageStream.close();
  }
}
