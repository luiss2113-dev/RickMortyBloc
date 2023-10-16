import 'dart:convert';

import 'character_item_model.dart';
import 'response_info.dart';

class Characters {
  final ResponseInfo? info;
  final List<CharacterItemModel>? results;

  Characters({
    this.info,
    this.results,
  });

  Characters copyWith({
    ResponseInfo? info,
    List<CharacterItemModel>? results,
  }) =>
      Characters(
        info: info ?? this.info,
        results: results ?? this.results,
      );

  factory Characters.fromRawJson(String str) =>
      Characters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        info: json["info"] == null ? null : ResponseInfo.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<CharacterItemModel>.from(
                json["results"]!.map((x) => CharacterItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}
