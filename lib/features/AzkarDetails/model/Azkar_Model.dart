import 'package:hive/hive.dart';
part 'Azkar_Model.g.dart';

@HiveType(typeId: 0)
class Zekr extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  int count;
  @HiveField(2)
  AzkarType type;
  @HiveField(3)
  bool added;
  Zekr({
    required this.text,
    required this.count,
    required this.type,
    this.added = false,
  });
}

@HiveType(typeId: 1)
enum AzkarType {
  @HiveField(0)
  morning,
  @HiveField(1)
  night,
  @HiveField(2)
  praying,
  @HiveField(3)
  saving,
  @HiveField(4)
  sleep,
  @HiveField(5)
  wakeUp,
  @HiveField(6)
  mosque,
  @HiveField(7)
  mostazed,
  @HiveField(8)
  ahadeth,
}
