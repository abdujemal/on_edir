class Store {
  String sid, img_url, itemName, itemDescription, dateTime;

  Store(this.img_url, this.itemDescription, this.itemName, this.sid,
      this.dateTime);

  Map<String, Object> toFirebaseMap(Store store) {
    return {
      "sid": store.sid,
      "img_url": store.img_url,
      "itemDescription": store.itemDescription,
      "itemName": store.itemName,
      "dateTime": store.dateTime
    };
  }

  Store.fromFirebaseMap(Map<dynamic, dynamic> data)
      : sid = data["sid"],
        img_url = data["img_url"],
        itemDescription = data["itemDescription"],
        itemName = data["itemName"],
        dateTime = data["dateTime"];
}
