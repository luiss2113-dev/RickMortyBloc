
import 'dart:convert';

import '../../utils/enums.dart';

class ItemCharacter {
    final int? id;
    final String? name;
    final StatusCharacter? status;
    final String? species;
    final String? type;
    final GenderCharacter? gender;
    final Location? origin;
    final Location? location;
    final String? image;
    final List<String>? episode;
    final String? url;
    final DateTime? created;

    ItemCharacter({
        this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.origin,
        this.location,
        this.image,
        this.episode,
        this.url,
        this.created,
    });

    ItemCharacter copyWith({
        int? id,
        String? name,
        StatusCharacter? status,
        String? species,
        String? type,
        GenderCharacter? gender,
        Location? origin,
        Location? location,
        String? image,
        List<String>? episode,
        String? url,
        DateTime? created,
    }) => 
        ItemCharacter(
            id: id ?? this.id,
            name: name ?? this.name,
            status: status ?? this.status,
            species: species ?? this.species,
            type: type ?? this.type,
            gender: gender ?? this.gender,
            origin: origin ?? this.origin,
            location: location ?? this.location,
            image: image ?? this.image,
            episode: episode ?? this.episode,
            url: url ?? this.url,
            created: created ?? this.created,
        );

    factory ItemCharacter.fromRawJson(String str) => ItemCharacter.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemCharacter.fromJson(Map<String, dynamic> json) => ItemCharacter(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: json["species"],
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null ? [] : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": species,
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}


final genderValues = EnumValues({
    "Female": GenderCharacter.FEMALE,
    "Male": GenderCharacter.MALE,
    "unknown": GenderCharacter.UNKNOWN
});

class Location {
    final String? name;
    final String? url;

    Location({
        this.name,
        this.url,
    });

    Location copyWith({
        String? name,
        String? url,
    }) => 
        Location(
            name: name ?? this.name,
            url: url ?? this.url,
        );

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

final statusValues = EnumValues({
    "Alive": StatusCharacter.ALIVE,
    "Dead": StatusCharacter.DEAD,
    "unknown": StatusCharacter.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
