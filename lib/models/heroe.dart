class Heroe {
  final String id;
  final String nombre;
  final String bio;
  final String img;
  final DateTime aparicion;
  final String casa;

  Heroe({
    required this.id,
    required this.nombre,
    required this.bio,
    required this.img,
    required this.aparicion,
    required this.casa,
  });

  factory Heroe.fromJson(Map<String, dynamic> json) => Heroe(
        id: json["_id"],
        nombre: json["nombre"],
        bio: json["bio"],
        img: json["img"],
        aparicion: DateTime.parse(json["aparicion"]),
        casa: json["casa"],
      );
}
