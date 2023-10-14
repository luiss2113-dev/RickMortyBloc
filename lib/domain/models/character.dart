import 'dart:convert';

import 'character_item.dart';
import 'response_info.dart';

class Characters {
  final ResponseInfo? info;
  final List<ItemCharacter>? results;

  Characters({
    this.info,
    this.results,
  });

  Characters copyWith({
    ResponseInfo? info,
    List<ItemCharacter>? results,
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
            : List<ItemCharacter>.from(
                json["results"]!.map((x) => ItemCharacter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}
