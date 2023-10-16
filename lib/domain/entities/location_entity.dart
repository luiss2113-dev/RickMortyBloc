import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final int? _id;
  final String? _name;
  final String? _type;

  const LocationEntity({
    int id = 0,
    String name = '',
    String type = '',
  })  : _id = id,
        _name = name,
        _type = type;

  String get locationName => _name ?? 'Unknown';
  int get locationId => _id ?? 0;
  String get locationType => _type ?? 'N/A';

  @override
  List<Object?> get props => [_id, _name, _type];
}
