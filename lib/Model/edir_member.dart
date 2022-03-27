class EdirMember {
  String img_url, position, uid, userName;

  EdirMember(this.img_url, this.position, this.uid, this.userName);

  Map<String, Object> tofirebaseMap(EdirMember edirMember) {
    return {
      "img_url": edirMember.img_url,
      "position": edirMember.position,
      "uid": edirMember.uid,
      "userName": edirMember.userName
    };
  }

  EdirMember.fromFirebaseMap(Map<dynamic, dynamic> data)
      : img_url = data["img_url"],
        position = data["position"],
        uid = data["uid"],
        userName = data["userName"];
}
