class Product {
  final String id;
  final String referencia;
  final String nombre;
  final String marca;
  final String descripcion;
  final double precio;
  final int numeroDisponible;
  final String departamento;
  final String? imagenUrl;

  Product({
    required this.id,
    required this.referencia,
    required this.nombre,
    required this.marca,
    required this.descripcion,
    required this.precio,
    required this.numeroDisponible,
    required this.departamento,
    this.imagenUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      referencia: json['referencia'] ?? '',
      nombre: json['nombre'] ?? '',
      marca: json['marca'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] ?? 0).toDouble(),
      numeroDisponible: json['numeroDisponible'] ?? 0,
      departamento: json['departamento'] ?? '',
      imagenUrl: json['imagenUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referencia': referencia,
      'nombre': nombre,
      'marca': marca,
      'descripcion': descripcion,
      'precio': precio,
      'numeroDisponible': numeroDisponible,
      'departamento': departamento,
      'imagenUrl': imagenUrl,
    };
  }
}
