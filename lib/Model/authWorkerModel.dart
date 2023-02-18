class authWorkerModel
{
  String? username,phoneNo,email,type,id,profileimg;
  int? totalcomplaintcount,donecount,pendingcount;
  

  authWorkerModel({this.username,this.phoneNo,this.email,this.type,this.id,this.profileimg,this.totalcomplaintcount,this.donecount,this.pendingcount});
  //to method
  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "email":email,
      "username":username,
      "phoneNo":phoneNo,
      "type":type,
      "profileimg":profileimg,
      "totalcomplaintcount":totalcomplaintcount,
      "donecount":donecount,
      "pendingcount":pendingcount,
    };
  }
 
}