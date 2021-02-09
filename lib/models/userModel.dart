class Person{
  final String email;
  final String name;
  final String password;
  final String uid;

  Person({this.email, this.name, this.password, this.uid});

  createMap(){
    var personMap = Map<String, dynamic>();
    personMap['email']= email;
    personMap['password']= password;
    personMap['name']= name;
    personMap['uid']= uid;
    return personMap;
  }
}