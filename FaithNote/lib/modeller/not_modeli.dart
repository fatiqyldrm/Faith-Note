
import 'package:hive/hive.dart';
part 'not_modeli.g.dart';

@HiveType(typeId: 0)

class NotModeli extends HiveObject {

  @HiveField(0)
  String baslik;

  @HiveField(1)
  String aciklama;

  NotModeli({required this.baslik, required this.aciklama});
}
