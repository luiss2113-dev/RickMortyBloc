import 'response_info.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'dart:convert' show json;
import 'character_item_model.dart';

class Characters extends Equatable {
  final ResponseInfo? info;
  final List<CharacterItemModel>? results;

  const Characters({
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

  int get nextPage {
    try {
      return int.parse(info!.next!.split('=')[1]);
    } catch (e) {
      return 1;
    }
  }

  bool get hasNextPage => info?.next != null ? true : false;

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

  @override
  List<Object?> get props => [info, results];
}
