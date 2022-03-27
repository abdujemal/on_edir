class Chat {
  String text, cid, userName, img_url;

  Chat(this.text, this.cid, this.userName, this.img_url);

  Map<String, Object> toFirebaseMap(Chat chat) {
    return {
      "text": chat.text,
      "cid": chat.cid,
      "userName": chat.userName,
      "img_url": chat.img_url
    };
  }

  Chat.fromFirebaseMap(Map<dynamic, dynamic> data)
      : text = data["text"],
        cid = data["cid"],
        userName = data["userName"],
        img_url = data["img_url"];
}
