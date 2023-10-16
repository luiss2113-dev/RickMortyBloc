import 'dart:convert';

import '../../utils/enums.dart';
import '../entities/character_entity.dart';

class CharacterItemModel extends CharacterEntity {
  final String? species;
  final String? type;
  final GenderCharacter? gender;
  final Location? origin;
  final Location? location;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  CharacterItemModel({
    super.id,
    super.name,
    super.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    super.image,
    this.episode,
    this.url,
    this.created,
  });

  CharacterItemModel copyWith({
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
      CharacterItemModel(
        id: id ?? characterId,
        name: name ?? characterName,
        status: status ?? characterStatus,
        species: species ?? this.species,
        type: type ?? this.type,
        gender: gender ?? this.gender,
        origin: origin ?? this.origin,
        location: location ?? this.location,
        image: image ?? characterImage,
        episode: episode ?? this.episode,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory CharacterItemModel.fromRawJson(String str) =>
      CharacterItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterItemModel.fromJson(Map<String, dynamic> json) => CharacterItemModel(
        id: json["id"],
        name: json["name"],
        status: characterStatusValues.map[json["status"]]!,
        species: json["species"],
        type: json["type"],
        gender: charactersGenderValues.map[json["gender"]]!,
        origin:
            json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": characterId,
        "name": characterName,
        "status": characterStatusValues.reverse[characterStatus],
        "species": species,
        "type": type,
        "gender": charactersGenderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": characterStatus,
        "episode":
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

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

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

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
