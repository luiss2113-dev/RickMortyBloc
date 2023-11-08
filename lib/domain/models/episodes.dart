import 'package:equatable/equatable.dart';

import 'response_info.dart';
import 'episode_item_model.dart';
import 'dart:convert';

class Episodes extends Equatable {
  final ResponseInfo? info;
  final List<EpisodeItemModel>? results;

  const Episodes({
    this.info,
    this.results,
  });

  Episodes copyWith({
    ResponseInfo? info,
    List<EpisodeItemModel>? results,
  }) =>
      Episodes(
        info: info ?? this.info,
        results: results ?? this.results,
      );

  bool get hasNextPage => info?.next != null ? true : false;

  int get nextPage {
    try {
      return int.parse(info!.next!.split('=')[1]);
    } catch (e) {
      return 1;
    }
  }

  factory Episodes.fromRawJson(String str) =>
      Episodes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        info: json["info"] == null ? null : ResponseInfo.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<EpisodeItemModel>.from(
                json["results"]!.map((x) => EpisodeItemModel.fromJson(x))),
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
