import 'package:test_app/models/heroe.dart';
import 'package:test_app/models/id_multimedia.dart';

class Multimedia {
  final String id;
  final Heroe heroe;
  final IdMultimedia multimedia;
  final DateTime fechaCreacion;

  Multimedia({
    required this.id,
    required this.heroe,
    required this.multimedia,
    required this.fechaCreacion,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        id: json["_id"],
        heroe: Heroe.fromJson(json["IdHeroe"]),
        multimedia: IdMultimedia.fromJson(json["IdMultimedia"]),
        fechaCreacion: DateTime.parse(json["fecha_creacion"]),
      );
}
