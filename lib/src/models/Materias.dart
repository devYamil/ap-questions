class Materias {
  final int id;
  final int idInstitucion;
  final String imagenMateria;
  final String nombreMateria;
  final String descripcion;
  // INICIALIZAR EL POST EN ESTE CASO ESE SERIA EL CONSTRUCTOR
  Materias({
    this.id,
    this.idInstitucion,
    this.imagenMateria,
    this.nombreMateria,
    this.descripcion,
  });
  factory Materias.formJson(Map<String, dynamic> json) {
    return new Materias(
      id: json['id'],
      idInstitucion: json['id_institucion'],
      imagenMateria: json['imagen_materia'],
      nombreMateria: json['nombre_materia'],
      descripcion: json['descripcion'],
    );
  }
}
