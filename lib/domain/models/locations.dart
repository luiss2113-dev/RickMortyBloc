import 'dart:convert';

import 'location_item.dart';
import 'response_info.dart';

class Locations {
    final ResponseInfo? info;
    final List<LocationItem>? results;

    Locations({
        this.info,
        this.results,
    });

    Locations copyWith({
        ResponseInfo? info,
        List<LocationItem>? results,
    }) => 
        Locations(
            info: info ?? this.info,
            results: results ?? this.results,
        );

    factory Locations.fromRawJson(String str) => Locations.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: json["info"] == null ? null : ResponseInfo.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<LocationItem>.from(json["results"]!.map((x) => LocationItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}
