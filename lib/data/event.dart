import 'dart:convert';

import 'chamber.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String id;
  Chamber chamber;
  String username;
  int dateStart;
  int dateEnd;
  bool cycle;

  Event({
    this.id,
    this.chamber,
    this.username,
    this.dateStart,
    this.dateEnd,
    this.cycle,
  });

  factory Event.fromJson(Map<String, dynamic> json) => new Event(
        id: json["id"],
      chamber: json["chamber"],
        username: json["username"],
        dateStart: json["dateStart"],
        dateEnd: json["dateEnd"],
        cycle: json["cycle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chamber": chamber,
        "username": username,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "cycle": cycle,
      };
}
