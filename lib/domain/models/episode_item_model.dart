import 'dart:convert';

import '../entities/entities.dart';

class EpisodeItemModel extends EpisodeEntity {
  final String? _airDate;
  final List<String>? _characters;
  final String? _url;
  final DateTime? _created;

  const EpisodeItemModel({
    super.id,
    super.name,
    String? airDate,
    super.episode,
    List<String>? characters,
    String? url,
    DateTime? created,
  })  : _created = created,
        _url = url,
        _characters = characters,
        _airDate = airDate;

  String get airDate => _airDate ?? DateTime.now().toIso8601String();
  int get countCharacters => _characters?.length ?? 0;

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
        airDate: airDate ?? _airDate,
        episode: episode ?? this.episode,
        characters: characters ?? _characters,
        url: url ?? _url,
        created: created ?? _created,
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
        "air_date": _airDate,
        "episode": episode,
        "characters": _characters == null
            ? []
            : List<dynamic>.from(_characters!.map((x) => x)),
        "url": _url,
        "created": _created?.toIso8601String(),
      };
}
