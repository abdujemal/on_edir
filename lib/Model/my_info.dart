class MyInfo {
  String email,
      familyMembers,
      img_url,
      noOfFamily,
      uid,
      userBio,
      userName,
      userPhone,
      userRsPhone;
      
  MyInfo(this.email, this.familyMembers, this.img_url, this.noOfFamily,
      this.uid, this.userBio, this.userName, this.userPhone, this.userRsPhone);
      
  Map<String, Object> toFirebaseMap(MyInfo data) {
    return {
      "email": data.email,
      "familyMembers": data.familyMembers,
      "img_url": data.img_url,
      "noOfFamily": data.noOfFamily,
      "uid": data.uid,
      "userBio": data.userBio,
      "userName": data.userName,
      "userPhone": data.userPhone,
      "userRsPhone": data.userRsPhone,
    };
  }

  MyInfo.fromFirebaseMap(Map<dynamic, dynamic> data)
      : email = data["email"],
        familyMembers = data["familyMembers"],
        img_url = data["img_url"],
        noOfFamily = data["noOfFamily"],
        uid = data["uid"],
        userBio = data["userBio"],
        userName = data["userName"],
        userPhone = data["userPhone"],
        userRsPhone = data["userRsPhone"];
}
