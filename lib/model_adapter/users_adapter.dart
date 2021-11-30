import 'package:e_citizen/models/user_model.dart';
import 'package:hive/hive.dart';


class DataModelAdapter extends TypeAdapter<Users> {
  @override
  final typeId = 0;

  @override
  Users read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Users(
        lastname: fields[0] as String,
        firstname:  fields[1] as String,
        cardType: fields[2] as String,
        id: fields[3] as int,
        token: fields[4] as String,
        cardId: fields[5] as String,
        telephone:  fields[6] as String
    );
  }

  @override
  void write(BinaryWriter writer, Users obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lastname)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.cardId)
      ..writeByte(6)
     ..write(obj.telephone);
  }
}