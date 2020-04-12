import 'package:hive/hive.dart';

part 'theme_enum.g.dart';

@HiveType(typeId: 0)
enum ThemeEnum {
  @HiveField(0)
  light,

  @HiveField(1)
  dark,

  @HiveField(2)
  system,
}

// run
// flutter packages pub run build_runner build --delete-conflicting-outputs
// when changed