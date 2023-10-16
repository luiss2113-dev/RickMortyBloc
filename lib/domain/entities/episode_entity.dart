import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final int? _id;
  final String? _name;
  final String? _episode;

  const EpisodeEntity({
    int id = 0,
    String name = '',
    String episode = '',
  })  : _id = id,
        _name = name,
        _episode = episode;

  String get episodeName => _name ?? 'Unknown';
  int get episodeId => _id ?? 0;
  String get episode => _episode ?? 'N/A';

  @override
  List<Object?> get props => [_id, _name, _episode];
}
