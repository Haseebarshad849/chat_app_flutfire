class Messages{
  final String from;
  final String message;
  // final String me;
  final DateTime timeStamp;

  Messages({
    this.from,
    this.message,
    // this.me,
    this.timeStamp,
  });

  createMap(){
    var map= Map<String, dynamic>();
    map['message']= message;
    map['timestamp']=DateTime.now();
    map['from']= from;
    // map['me'] = me;
    return map;
  }

}
