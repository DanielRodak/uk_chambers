import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String chamberId;
  String username;
  int dateStart;
  int dateEnd;
  bool cycle;

  Event({
    this.chamberId,
    this.username,
    this.dateStart,
    this.dateEnd,
    this.cycle,
  });

  factory Event.fromJson(Map<String, dynamic> json) => new Event(
        chamberId: json["chamber_id"],
        username: json["username"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        cycle: json["cycle"],
      );

  Map<String, dynamic> toJson() => {
        "chamber_id": chamberId,
        "username": username,
        "date_start": dateStart,
        "date_end": dateEnd,
        "cycle": cycle,
      };
}
