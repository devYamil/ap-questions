class Products {
  final int id;
  final String item;
  final String descripcion;
  final double precio;
  final String imagen;
  // INICIALIZAR EL POST EN ESTE CASO ESE SERIA EL CONSTRUCTOR
  Products({
    this.id,
    this.item,
    this.descripcion,
    this.precio,
    this.imagen,
  });
  factory Products.formJson(Map<String, dynamic> json) {
    return new Products(
      id: json['id'],
      item: json['item'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      imagen: json['imagen'],
    );
  }
}
