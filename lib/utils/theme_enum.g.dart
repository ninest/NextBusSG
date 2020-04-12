// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeEnumAdapter extends TypeAdapter<ThemeEnum> {
  @override
  final typeId = 0;

  @override
  ThemeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeEnum.light;
      case 1:
        return ThemeEnum.dark;
      case 2:
        return ThemeEnum.system;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeEnum obj) {
    switch (obj) {
      case ThemeEnum.light:
        writer.writeByte(0);
        break;
      case ThemeEnum.dark:
        writer.writeByte(1);
        break;
      case ThemeEnum.system:
        writer.writeByte(2);
        break;
    }
  }
}
