import 'dart:convert';

import '../entities/entities.dart';

class EpisodeItemModel extends EpisodeEntity {
  final String? airDate;
  final List<String>? characters;
  final String? url;
  final DateTime? created;

  const EpisodeItemModel({
    super.id,
    super.name,
    this.airDate,
    super.episode,
    this.characters,
    this.url,
    this.created,
  });

  EpisodeItemModel copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  }) =>
      EpisodeItemModel(
        id: id ?? episodeId,
        name: name ?? episodeName,
        airDate: airDate ?? this.airDate,
        episode: episode ?? this.episode,
        characters: characters ?? this.characters,
        url: url ?? this.url,
        created: created ?? this.created,
      );

  factory EpisodeItemModel.fromRawJson(String str) =>
      EpisodeItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EpisodeItemModel.fromJson(Map<String, dynamic> json) =>
      EpisodeItemModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null
            ? []
            : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": episodeId,
        "name": episodeName,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null
            ? []
            : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
