import 'dart:convert';

import '../entities/entities.dart';

class LocationItemModel extends LocationEntity {
  final String? _dimension;
  final List<String>? _residents;
  final String? _url;
  final DateTime? _created;

  const LocationItemModel({
    super.id,
    super.name,
    super.type,
    String? dimension,
    List<String>? residents,
    String? url,
    DateTime? created,
  })  : _created = created,
        _url = url,
        _residents = residents,
        _dimension = dimension;

  String? get dimension => _dimension;
  int get countResidents => _residents?.length ?? 0;

  LocationItemModel copyWith({
    int? id,
    String? name,
    String? type,
    String? dimension,
    List<String>? residents,
    String? url,
    DateTime? created,
  }) =>
      LocationItemModel(
        id: id ?? locationId,
        name: name ?? locationName,
        type: type ?? locationType,
        dimension: dimension ?? _dimension,
        residents: residents ?? _residents,
        url: url ?? _url,
        created: created ?? _created,
      );

  factory LocationItemModel.fromRawJson(String str) =>
      LocationItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationItemModel.fromJson(Map<String, dynamic> json) =>
      LocationItemModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null
            ? []
            : List<String>.from(json["residents"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": locationId,
        "name": locationName,
        "type": locationType,
        "dimension": _dimension,
        "residents": _residents == null
            ? []
            : List<dynamic>.from(_residents!.map((x) => x)),
        "url": _url,
        "created": _created?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        _dimension,
        _residents,
        _url,
        _created,
        locationName,
        locationId,
        locationType,
      ];
}
