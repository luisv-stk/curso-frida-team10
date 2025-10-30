// File: add_product_screen.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() =>
      _AddProductScreenState();
}

class _AddProductScreenState
    extends State<AddProductScreen> {
  late DropzoneViewController controller;
  Uint8List? imageBytes;
  String? fileName;

  bool _isHovering =
      false; // Para efectos visuales al arrastrar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1ee),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // 🔹 Header superior
            Container(
              color: const Color(0xff5daa4c),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              height: 50,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'MI COMPRA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        ' SUPERMERCADO',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Francisco Perera',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            // 🔹 Barra de items
            Container(
              color: const Color(0xfff3f3f3),
              height: 50,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Item1'),
                  const Text('Item2'),
                  const Text('Item3'),
                  const Text('Item4'),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xffd9d9d9,
                      ),
                    ),
                    child: const Text(
                      '+ Añadir producto',
                      style: TextStyle(
                        color: Color(0xff363232),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 🔹 Contenido principal scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Color(0xff1e1e1e),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Añadir producto',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff131313),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 🔹 Zona principal con DropZone
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                // Fondo con imagen o texto
                                AnimatedContainer(
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _isHovering
                                          ? Colors.green
                                          : const Color(
                                              0xff5daa4c,
                                            ),
                                      width: 2.0,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      8.0,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: imageBytes != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            8.0,
                                          ),
                                          child:
                                              Image.memory(
                                            imageBytes!,
                                            fit: BoxFit
                                                .cover,
                                            width: double
                                                .infinity,
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: const [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Color(
                                                0xffecfae9,
                                              ),
                                              child: Icon(
                                                Icons
                                                    .cloud_upload,
                                                color:
                                                    Color(
                                                  0xff5daa4c,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              'Arrastra desde tu ordenador la imagen del producto',
                                              textAlign:
                                                  TextAlign
                                                      .center,
                                              style:
                                                  TextStyle(
                                                color:
                                                    Color(
                                                  0xff363232,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'El archivo no puede superar 2 MB y debe ser JPG o PNG',
                                              textAlign:
                                                  TextAlign
                                                      .center,
                                              style:
                                                  TextStyle(
                                                color:
                                                    Color(
                                                  0xff6e6e6e,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                // 🔹 Dropzone invisible encima
                                Positioned.fill(
                                  child: DropzoneView(
                                    onCreated: (ctrl) =>
                                        controller = ctrl,
                                    onHover: () {
                                      setState(
                                        () => _isHovering =
                                            true,
                                      );
                                    },
                                    onLeave: () {
                                      setState(
                                        () => _isHovering =
                                            false,
                                      );
                                    },
                                    onDrop:
                                        (dropzoneFile) async {
                                      try {
                                        setState(
                                          () =>
                                              _isHovering =
                                                  false,
                                        );

                                        final name =
                                            await controller
                                                .getFilename(
                                          dropzoneFile,
                                        );
                                        final mime =
                                            await controller
                                                .getFileMIME(
                                          dropzoneFile,
                                        );
                                        final size =
                                            await controller
                                                .getFileSize(
                                          dropzoneFile,
                                        );
                                        final bytes =
                                            await controller
                                                .getFileData(
                                          dropzoneFile,
                                        );

                                        if (!mime
                                            .startsWith(
                                          'image/',
                                        )) {
                                          ScaffoldMessenger
                                              .of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Solo se permiten imágenes.',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        if (size >
                                            2 *
                                                1024 *
                                                1024) {
                                          ScaffoldMessenger
                                              .of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'El archivo supera los 2 MB permitidos.',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        setState(() {
                                          imageBytes =
                                              bytes;
                                          fileName = name;
                                        });
                                      } catch (e) {
                                        debugPrint(
                                          'Error al procesar el archivo: $e',
                                        );
                                        ScaffoldMessenger
                                            .of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Error al procesar el archivo: $e',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // 🔹 Botones Borrar / Guardar
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      imageBytes = null;
                                      fileName = null;
                                    });
                                  },
                                  style: OutlinedButton
                                      .styleFrom(
                                    side: const BorderSide(
                                      color: Color(
                                        0xff6f7274,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Borrar',
                                    style: TextStyle(
                                      color: Color(
                                        0xff363232,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    if (imageBytes ==
                                        null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Selecciona o arrastra una imagen',
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Imagen "$fileName" lista para guardar.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton
                                      .styleFrom(
                                    backgroundColor:
                                        const Color(
                                      0xffd9d9d9,
                                    ),
                                  ),
                                  child: const Text(
                                    'Guardar',
                                    style: TextStyle(
                                      color: Color(
                                        0xff363232,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
