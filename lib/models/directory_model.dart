class DirectoryOS {
  final int? id;
  var dirName;
  var dirPath;
  DateTime? created;
  int? imageCount;
  var firstImgPath;
  DateTime? lastModified;
  String? newName;

  DirectoryOS({
    this.id,
    this.dirName,
    this.created,
    this.dirPath,
    this.firstImgPath,
    this.imageCount,
    this.lastModified,
    this.newName,
  });

  factory  DirectoryOS.fromJson(Map<String, dynamic> doc) {
    return  DirectoryOS(
      id: (int.tryParse(doc['id'])) ??
          1, //TODO: REMOVE THE PARSE ONCE RECEIVING REAL DATA
      dirName: doc['dirName'],
      created: doc['created'],
      dirPath: doc['dirPath'],
      firstImgPath: doc['firstImgPath'],
      imageCount: doc['imageCount'],
      lastModified: doc['lastModified'],
      newName: doc['newName'],
    );
  }

  factory DirectoryOS.fromDB(Map<String, dynamic> doc) {
    return DirectoryOS(
      id: doc['id'] ??
          1, //TODO: REMOVE THE PARSE ONCE RECEIVING REAL DATA
      dirName: doc['dir_name'],
      created: DateTime.parse(doc['created']),
      dirPath: doc['dir_path'],
      firstImgPath: doc['first_img_path'],
      imageCount: doc['image_count'],
      lastModified: DateTime.parse(doc['last_modified']),
      newName: doc['new_name'],
    );
  }

  toMap() {
    return {
      'id': id,
      'dirName': dirName,
      'created': created,
      'dirPath': dirPath,
      'firstImgPath': firstImgPath,
      'imageCount': imageCount,
      'lastModified': lastModified ?? "",
      'newName': newName ?? "",
    };
  }
  static List<DirectoryOS>? fromMapToList(List<Map<String, dynamic>> map){
    List<DirectoryOS> list=[];
    for(int i=0;i<map.length;i++){
      DirectoryOS directory=DirectoryOS(
        id: map[i]['id'] as int,
        dirName: map[i]['dir_name'] as String,
        created: DateTime.parse(map[i]['created']),
        dirPath: map[i]['dir_path'] as String,
        firstImgPath: map[i]['first_img_path'] as String,
        imageCount: map[i]['image_count'] as int,
        lastModified: DateTime.parse(map[i]['last_modified']),
        newName: map[i]['new_name'] as String,
      );
      list.add(directory);
    }
    return list;
  }

static DirectoryOS fromMap(Map<String, dynamic> map){
  return DirectoryOS(
    id: map['id'] as int,
    dirName: map['dir_name'] as String,
    created: DateTime.parse(map['created']),
    dirPath: map['dir_path'] as String,
    firstImgPath: map['first_img_path'] as String,
    imageCount: map['image_count'] as int,
    lastModified: DateTime.parse(map['last_modified']),
    newName: map['new_name'] as String,
  );
}
  @override
  String toString() {
    return 'DirectoryOS{dirName: $dirName, dirPath: $dirPath, created: $created, imageCount: $imageCount, firstImgPath: $firstImgPath, lastModified: $lastModified, newName: $newName}';
  }
}
