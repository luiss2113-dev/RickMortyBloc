import 'response_info.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'location_item_model.dart';
import 'dart:convert' show json;

class Locations extends Equatable {
  final ResponseInfo? info;
  final List<LocationItemModel>? results;

  const Locations({
    this.info,
    this.results,
  });

  Locations copyWith({
    ResponseInfo? info,
    List<LocationItemModel>? results,
  }) =>
      Locations(
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

  factory Locations.fromRawJson(String str) =>
      Locations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: json["info"] == null ? null : ResponseInfo.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<LocationItemModel>.from(
                json["results"]!.map((x) => LocationItemModel.fromJson(x))),
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
