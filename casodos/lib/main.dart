import 'package:flutter/material.dart';
import 'package:casodos/screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

/// Clase raíz de la aplicación
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supermercado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff5daa4c),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff5daa4c),
          foregroundColor: Colors.white,
        ),
      ),
      home: HomeScreen(),
    );
  }
}

/// Pantalla principal del supermercado
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double gridHeight =
        MediaQuery.of(context).size.height - 260;

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      appBar: AppBar(
        title: const Text('Hola, Francisco Perera'),
        actions: [
          _buildLanguageDropdown(),
          TextButton(
            onPressed: () {},
            child: const Text('Ayuda'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Cerrar sesión'),
          ),
          TextButton(
            onPressed: () {
              // Navegar a gestión de productos
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(),
                ),
              );
            },
            child: const Text('Gestión de tienda'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryTabs(),
            _buildSectionTitle('Conservas de pescado'),
            SizedBox(
              height: gridHeight,
              child: _buildProductGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<String>(
      value: 'Español',
      items: const [
        DropdownMenuItem(
          child: Text('Español'),
          value: 'Español',
        ),
      ],
      onChanged: (value) {},
      underline: Container(),
      style: const TextStyle(color: Colors.white),
      dropdownColor: const Color(0xff5daa4c),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Center(
        child: Text(
          'MI COMPRA SUPERMERCADO',
          style: TextStyle(
            color: Color(0xff363232),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 2,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            DropdownButton<String>(
              value: 'Todos',
              items: const [
                DropdownMenuItem(
                  value: 'Todos',
                  child: Text('Todos'),
                ),
              ],
              onChanged: (value) {},
              underline: Container(),
              style: const TextStyle(
                color: Color(0xff1c1b1f),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Buscar producto',
                  border: UnderlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Opcional: implementar búsqueda en tiempo real
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    const categories = [
      'ALIMENTACIÓN',
      'PLATOS PREPARADOS',
      'FERRETERÍA',
      'JARDINERÍA',
    ];
    return Container(
      color: const Color(0xfff1f1ee),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categories
            .map(
              (cat) => TextButton(
                onPressed: () {},
                child: Text(
                  cat,
                  style: const TextStyle(
                    color: Color(0xff363232),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xff363232),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    // Actualmente mock de 12 productos. Puedes reemplazarlo por API.
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.65,
          ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return ProductCard();
      },
    );
  }
}

/// Widget de producto individual
class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(
              'https://placehold.co/400x400/jpg',
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            const Text(
              '5,65 €',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Nombre'),
            const Text('Cantidad'),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {},
                ),
                const Text('1'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff5daa4c),
                minimumSize: const Size(
                  double.infinity,
                  36,
                ),
              ),
              child: const Text(
                'Añadir al carro',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
