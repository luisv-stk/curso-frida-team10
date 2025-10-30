import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  /// URL base de la API. Cambiar según entorno.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://tu-api.com/api',
  );

  /// ===========================
  /// Productos
  /// ===========================

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/productos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(
          response.body,
        );
        return data
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Error al cargar productos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/productos/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Producto no encontrado');
      } else {
        throw Exception(
          'Error al obtener producto: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener producto: $e');
    }
  }

  /// Crear o actualizar producto (unificado para simplificar)
  Future<Product> saveProduct({
    String? id, // Si es null → crear, si no → actualizar
    required String referencia,
    required String nombre,
    required String marca,
    required String descripcion,
    required double precio,
    required int numeroDisponible,
    required String departamento,
    Uint8List? imagenBytes,
    String? imagenNombre,
  }) async {
    try {
      final isUpdate = id != null;
      final uri = isUpdate
          ? Uri.parse('$baseUrl/productos/$id')
          : Uri.parse('$baseUrl/productos');

      final request = http.MultipartRequest(
        isUpdate ? 'PUT' : 'POST',
        uri,
      );

      // Campos del producto
      request.fields['referencia'] = referencia;
      request.fields['nombre'] = nombre;
      request.fields['marca'] = marca;
      request.fields['descripcion'] = descripcion;
      request.fields['precio'] = precio.toString();
      request.fields['numeroDisponible'] = numeroDisponible
          .toString();
      request.fields['departamento'] = departamento;

      // Imagen opcional
      if (imagenBytes != null && imagenNombre != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'imagen',
            imagenBytes,
            filename: imagenNombre,
          ),
        );
      }

      // Enviar request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Error al ${isUpdate ? 'actualizar' : 'crear'} producto: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error al guardar producto: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/productos/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (![200, 202, 204].contains(response.statusCode)) {
        throw Exception(
          'Error al eliminar producto: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al eliminar producto: $e');
    }
  }

  /// ===========================
  /// Búsquedas y filtros
  /// ===========================

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/productos/search?q=${Uri.encodeComponent(query)}',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(
          response.body,
        );
        return data
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Error al buscar productos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al buscar productos: $e');
    }
  }

  Future<List<Product>> getProductsByDepartment(
    String departamento,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/productos/departamento/$departamento',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(
          response.body,
        );
        return data
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Error al obtener productos: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }

  /// ===========================
  /// Estadísticas (opcional)
  /// ===========================

  Future<Map<String, dynamic>> getStats() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/productos/stats'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          'Error al obtener estadísticas: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener estadísticas: $e');
    }
  }
}
