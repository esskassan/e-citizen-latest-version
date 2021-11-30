class ImageOS {
  int? idx;
  String imgPath;
  int? shouldCompress;

  ImageOS({
    this.idx,
    required this.imgPath,
    this.shouldCompress,
  });
  factory ImageOS.fromJson(Map<String, dynamic> doc) {
    return ImageOS(
      idx: (int.tryParse(doc['idx'])) ??
          1, //TODO: REMOVE THE PARSE ONCE RECEIVING REAL DATA
      imgPath: doc['imgPath'],
      shouldCompress: doc['shouldCompress'],
    );
  }

  factory ImageOS.fromDB(Map<String, dynamic> doc) {
    return ImageOS(
      idx: doc['idx']??
          1, //TODO: REMOVE THE PARSE ONCE RECEIVING REAL DATA
      imgPath: doc['imgPath'],
      shouldCompress: doc['shouldCompress'],
    );
  }

  toMap() {
    return {
      'idx': idx,
      'imgPath': imgPath,
      'shouldCompress': shouldCompress,
    };
  }
  @override
  String toString() {
    return 'ImageOS{idx: $idx, imgPath: $imgPath, shouldCompress: $shouldCompress}';
  }
}