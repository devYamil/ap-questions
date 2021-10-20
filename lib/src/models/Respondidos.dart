class Respondidos {
  final int id;
  final int idUsuario;
  final int idPregunta;
  final int respuesta;
  // INICIALIZAR EL POST EN ESTE CASO ESE SERIA EL CONSTRUCTOR
  Respondidos({
    this.id,
    this.idUsuario,
    this.idPregunta,
    this.respuesta,
  });
  factory Respondidos.formJson(Map<String, dynamic> json) {
    if(json != 'null' && json != null){
      return new Respondidos(
        id: json['id'],
        idUsuario: json['id_usuario'],
        idPregunta: json['id_pregunta'],
        respuesta: json['respuesta']
      );
    }else{
      return new Respondidos(
          id: 0,
          idUsuario: 0,
          idPregunta: 0,
          respuesta: 0
      );
    }
  }
}