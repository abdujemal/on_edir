class Store {
  String sid, img_url, itemName, itemDescription, dateTime, quantity;

  Store(this.img_url, this.itemDescription, this.itemName, this.sid,
      this.dateTime, this.quantity);

  Map<String, Object> toFirebaseMap(Store store) {
    return {
      "sid": store.sid,
      "img_url": store.img_url,
      "itemDescription": store.itemDescription,
      "itemName": store.itemName,
      "dateTime": store.dateTime,
      "quantity": store.quantity
    };
  }

  Store.fromFirebaseMap(Map<dynamic, dynamic> data)
      : sid = data["sid"],
        img_url = data["img_url"],
        itemDescription = data["itemDescription"],
        itemName = data["itemName"],
        dateTime = data["dateTime"],
        quantity = data["quantity"];
}
