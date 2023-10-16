import 'dart:convert';

import 'package:flutter/material.dart';

import '../../utils/enums.dart';
import '../entities/character_entity.dart';

class CharacterItemModel extends CharacterEntity {
  final String? _species;
  final String? _type;
  final GenderCharacter? _gender;
  final Location? _origin;
  final Location? _location;
  final List<String>? _episode;
  final String? _url;
  final DateTime? _created;

  CharacterItemModel({
    super.id,
    super.name,
    super.status,
    String? species,
    String? type,
    GenderCharacter? gender,
    Location? origin,
    Location? location,
    super.image,
    List<String>? episode,
    String? url,
    DateTime? created,
  })  : _created = created,
        _url = url,
        _location = location,
        _origin = origin,
        _gender = gender,
        _species = species,
        _type = type,
        _episode = episode;

  String get especies => _species ?? "N/A";
  IconData get status => statusIcon(characterStatus);
  IconData get genreIconP => genreIcon(_gender ?? GenderCharacter.empty);
  String get genre =>
      charactersGenderValues.reverse[_gender ?? GenderCharacter.empty] ?? "N/A";
  String get origen => _origin?.name ?? "N/A";
  String get location => _location?.name ?? "N/A";
  int get episodeCount => _episode?.length ?? 0;

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
        species: species ?? _species,
        type: type ?? _type,
        gender: gender ?? _gender,
        origin: origin ?? _origin,
        location: location ?? _location,
        image: image ?? characterImage,
        episode: episode ?? _episode,
        url: url ?? _url,
        created: created ?? _created,
      );

  factory CharacterItemModel.fromRawJson(String str) =>
      CharacterItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterItemModel.fromJson(Map<String, dynamic> json) =>
      CharacterItemModel(
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
        "species": _species,
        "type": _type,
        "gender": charactersGenderValues.reverse[_gender],
        "origin": _origin?.toJson(),
        "location": _location?.toJson(),
        "image": characterStatus,
        "episode":
            _episode == null ? [] : List<dynamic>.from(_episode!.map((x) => x)),
        "url": _url,
        "created": _created?.toIso8601String(),
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
