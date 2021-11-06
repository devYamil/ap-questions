class Respuestas {
  final int id;
  final int idPregunta;
  final int nroRespuesta;
  final String descripcionRespuesta;
  final String imagenRespuestas;
  // INICIALIZAR EL POST EN ESTE CASO ESE SERIA EL CONSTRUCTOR
  Respuestas({
    this.id,
    this.idPregunta,
    this.nroRespuesta,
    this.descripcionRespuesta,
    this.imagenRespuestas,
  });
  factory Respuestas.formJson(Map<String, dynamic> json) {
    return new Respuestas(
      id: json['id'],
      idPregunta: json['id_pregunta'],
      nroRespuesta: json['nro_respuesta'],
      descripcionRespuesta: json['descripcion_respuesta'],
      imagenRespuestas: json['imagen_respuesta'],
    );
  }
}
