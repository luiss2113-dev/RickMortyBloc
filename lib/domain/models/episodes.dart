import 'dart:convert';

import 'episode_item.dart';
import 'response_info.dart';

class Episodes {
    final ResponseInfo? info;
    final List<EpisodeItem>? results;

    Episodes({
        this.info,
        this.results,
    });

    Episodes copyWith({
        ResponseInfo? info,
        List<EpisodeItem>? results,
    }) => 
        Episodes(
            info: info ?? this.info,
            results: results ?? this.results,
        );

    factory Episodes.fromRawJson(String str) => Episodes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        info: json["info"] == null ? null : ResponseInfo.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<EpisodeItem>.from(json["results"]!.map((x) => EpisodeItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

