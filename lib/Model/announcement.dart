class Announcement {
  String title, description, dateTime, aid;

  Announcement(this.dateTime, this.description, this.title, this.aid);

  Map<String, Object> toFirebaseMap(Announcement announcement) {
    return {
      "title": announcement.title,
      "description": announcement.description,
      "dateTime": announcement.dateTime,
      "aid": announcement.aid
    };
  }

  Announcement.fromFirebaseMap(Map<dynamic, dynamic> data)
      : title = data["title"],
        description = data["description"],
        dateTime = data["dateTime"],
        aid = data["aid"];
}
