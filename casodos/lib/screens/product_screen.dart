// File: product_screen.dart

import 'package:casodos/models/product_model.dart';
import 'package:casodos/services/api_service.dart';
import 'package:flutter/material.dart';
import 'add_product_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() =>
      _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final products = await _apiService.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshProducts() async =>
      await _loadProducts();

  Future<void> _deleteProduct(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar este producto?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _apiService.deleteProduct(id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Producto eliminado correctamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
        _refreshProducts();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _navigateToAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddProductScreen()),
    );

    // Si se añadió un producto, refrescar
    if (result == true) {
      _refreshProducts();
    }
  }

  List<Product> get _filteredProducts {
    if (_searchQuery.isEmpty) return _products;
    return _products.where((product) {
      final query = _searchQuery.toLowerCase();
      return product.nombre.toLowerCase().contains(query) ||
          product.referencia.toLowerCase().contains(
            query,
          ) ||
          product.marca.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      appBar: AppBar(
        backgroundColor: const Color(0xff5daa4c),
        title: const Text('Francisco Perera'),
        actions: [
          Row(
            children: [
              for (var i = 1; i <= 4; i++)
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Item$i',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ElevatedButton.icon(
                onPressed: _navigateToAddProduct,
                icon: const Icon(Icons.add),
                label: const Text('Añadir producto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2e3d3c),
                  foregroundColor: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: _refreshProducts,
                tooltip: 'Actualizar productos',
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshProducts,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(width),
                const SizedBox(height: 16),
                _buildTitle(),
                const SizedBox(height: 16),
                _buildContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xfff1f1ee),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                'https://placehold.co/400x400/jpg',
                height: 50,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: const [
                  Text(
                    'MI COMPRA',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'SUPERMERCADO',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffd9d9d9),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                '${_products.length} productos cargados',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              onChanged: (value) =>
                  setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Buscar producto',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Productos en tienda',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xff5daa4c),
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Error al cargar productos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _refreshProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5daa4c),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredProducts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                _searchQuery.isEmpty
                    ? 'No hay productos disponibles'
                    : 'No se encontraron productos',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _searchQuery.isEmpty
                    ? 'Añade tu primer producto usando el botón "Añadir producto"'
                    : 'Intenta con otra búsqueda',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DataTable(
          columnSpacing: 16,
          headingRowColor: MaterialStateColor.resolveWith(
            (states) => const Color(0xfff1f1ee),
          ),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          columns: const [
            DataColumn(label: Text('Referencia')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Marca')),
            DataColumn(label: Text('Descripción')),
            DataColumn(label: Text('Precio')),
            DataColumn(label: Text('Nº Disp')),
            DataColumn(label: Text('Departamento')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: _filteredProducts.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product.referencia)),
                DataCell(Text(product.nombre)),
                DataCell(Text(product.marca)),
                DataCell(
                  SizedBox(
                    width: 200,
                    child: Text(
                      product.descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    '${product.precio.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataCell(
                  Text(product.numeroDisponible.toString()),
                ),
                DataCell(Text(product.departamento)),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xff5daa4c),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Función de edición próximamente',
                              ),
                            ),
                          );
                        },
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            _deleteProduct(product.id),
                        tooltip: 'Eliminar',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
