
import 'package:hive/hive.dart';
import 'package:notprojem/modeller/not_modeli.dart';

class Kutular {

  static Box<NotModeli> getData() => Hive.box<NotModeli>("notlar");
}

