import 'package:intl/intl.dart';

class MyLocalizations {
  String get helloWorld => Intl.message(
    'Hello World',
    name: 'helloWorld',
    desc: 'The conventional newborn programmer greeting',
  );
}