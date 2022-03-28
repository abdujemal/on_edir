import 'dart:math';

class PaymentRequest {
  String senderId,
      receiverId,
      state,
      title,
      description,
      pid,
      eid;
  PaymentRequest(this.senderId, this.description,
      this.receiverId, this.state, this.title, this.pid, this.eid);

  Map<String, Object> toFirbaseMap(PaymentRequest paymentRequest) {
    return {
      "senderId": paymentRequest.senderId,
      "receiverId": paymentRequest.receiverId,
      "state": paymentRequest.state,
      "title": paymentRequest.title,
      "description": paymentRequest.description,
      "pid": paymentRequest.pid,
      "eid": paymentRequest.eid
    };
  }

  PaymentRequest.fromFirebaseMap(Map<dynamic, dynamic> data)
      : senderId = data["senderId"],
        receiverId = data["receiverId"],
        state = data["state"],
        title = data["title"],
        description = data["description"],
        pid = data["pid"],
        eid = data["eid"];
}
