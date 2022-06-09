class StoreItemRequest {
  String srid,
      pid,
      p_img,
      reason,
      dateOfReturn,
      date,
      state,
      uid,
      eid,
      p_name,
      creatorId;

  StoreItemRequest(
      this.creatorId,
      this.date,
      this.dateOfReturn,
      this.eid,
      this.p_img,
      this.pid,
      this.reason,
      this.srid,
      this.state,
      this.uid,
      this.p_name);

  Map<String, Object> toFirebaseMap(StoreItemRequest storeItemRequest) => {
        "srid": storeItemRequest.srid,
        "pid": storeItemRequest.pid,
        "p_img": storeItemRequest.p_img,
        "reason": storeItemRequest.reason,
        "dateOfReturn": storeItemRequest.dateOfReturn,
        "date": storeItemRequest.date,
        "state": storeItemRequest.state,
        "uid": storeItemRequest.uid,
        "eid": storeItemRequest.eid,
        "creatorId": storeItemRequest.creatorId,
        'p_name': storeItemRequest.p_name
      };

  StoreItemRequest.fromFirebaseMap(Map<dynamic, dynamic> data)
      : srid = data["srid"],
        pid = data["pid"],
        p_img = data["p_img"],
        reason = data["reason"],
        dateOfReturn = data["dateOfReturn"],
        date = data["date"],
        state = data["state"],
        uid = data["uid"],
        eid = data["eid"],
        creatorId = data["creatorId"],
        p_name = data["p_name"];
}
