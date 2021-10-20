import 'Respuestas.dart';
import 'Respondidos.dart';

class Preguntas {
  final int id;
  final int idMateria;
  final int nroPregunta;
  final String descripcionPregunta;
  final int tipoPregunta;
  final int respuestaCorrecta;
  final String imagenPreguntas;
  List<Respuestas> respuestas;
  Respondidos respondidos;
  // INICIALIZAR EL POST EN ESTE CASO ESE SERIA EL CONSTRUCTOR
  Preguntas({
    this.id,
    this.idMateria,
    this.nroPregunta,
    this.descripcionPregunta,
    this.tipoPregunta,
    this.respuestaCorrecta,
    this.imagenPreguntas,
    this.respuestas,
    this.respondidos,
  });
  factory Preguntas.formJson(Map<String, dynamic> json) {
    return new Preguntas(
      id: json['id'],
      idMateria: json['id_materia'],
      nroPregunta: json['nro_pregunta'],
      descripcionPregunta: json['descripcion_pregunta'],
      tipoPregunta: json['tipo_pregunta'],
      respuestaCorrecta: json['respuesta_correcta'],
      imagenPreguntas: json['imagen_preguntas'],
      respuestas: List<Respuestas>.from(json["respuestas"].map((resp) => Respuestas.formJson(resp))),
      respondidos: Respondidos.formJson(json["respondidos"])
    );
  }
}
