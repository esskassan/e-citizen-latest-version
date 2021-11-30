import 'package:e_citizen/models/directory_model.dart';
import 'package:e_citizen/models/image_model.dart';
import 'package:e_citizen/models/user_model.dart';
import 'package:hive/hive.dart';


class DataModelAdapter extends TypeAdapter<ImageOS> {
  @override
  final typeId = 0;

  @override
  ImageOS read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageOS(
      idx: fields[0] as int?,
      imgPath:  fields[1] as String,
      shouldCompress: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageOS obj) {
    writer
      ..writeByte(0)
      ..writeByte(0)
      ..write(obj.idx)
      ..writeByte(1)
      ..write(obj.imgPath)
      ..writeByte(2)
      ..write(obj.shouldCompress);
  }
}