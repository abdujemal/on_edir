class Edir {
  String amountOfMoney,
      created_by,
      durationOfPayment,
      edirAddress,
      edirBio,
      edirName,
      eid,
      img_url,
      rules;
  Edir(
      this.amountOfMoney,
      this.created_by,
      this.durationOfPayment,
      this.edirAddress,
      this.edirBio,
      this.edirName,
      this.eid,
      this.img_url,
      this.rules);

  Map<String, Object> toFirebaseMap(Edir edir) {
    return {
      "edirAddress": edir.edirAddress,
      "edirBio": edir.edirBio,
      "edirName": edirName,
      "eid": edir.eid,
      "img_url": edir.img_url,
      "rules": edir.rules,
      "created_by": edir.created_by,
      "durationOfPayment": edir.durationOfPayment,
      "amountOfMoney": edir.amountOfMoney
    };
  }

  Edir.fromFirebaseMap(Map<dynamic, dynamic> data)
      : edirAddress = data["edirAddress"],
        edirBio = data["edirBio"],
        edirName = data["edirName"],
        eid = data["eid"],
        img_url = data["img_url"],
        rules = data["rules"],
        created_by = data["created_by"],
        durationOfPayment = data["durationOfPayment"],
        amountOfMoney = data["amountOfMoney"];
}
