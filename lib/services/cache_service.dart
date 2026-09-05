// Servicio de guardado de imagenes en cache
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static final CacheManager _cacheManager = CacheManager(
    Config(
      'imagenesProductos',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  static Future<FileInfo?> obtenerImagen(String url) async {
    try {
      return await _cacheManager.getFileFromCache(url);
    } catch (e) {
      print('CACHE: error al buscar imagen: $e');
      return null;
    }
  }

  static Future<File> descargarImagen(String url) async {
    print('CACHE: buscando imagen: $url');

    final fileInfo = await _cacheManager.getFileFromCache(url);

    if (fileInfo != null) {
      print('CACHE: imagen encontrada en cache');
      print('CACHE: archivo: ${fileInfo.file.path}');
      print('CACHE: válida hasta: ${fileInfo.validTill}');

      return fileInfo.file;
    }

    print('CACHE: imagen no encontrada, descargando...');

    final file = await _cacheManager.getSingleFile(url);

    print('CACHE: imagen descargada y guardada en cache');
    print('CACHE: archivo: ${file.path}');

    return file;
  }

  static Future<void> limpiarCache() async {
    await _cacheManager.emptyCache();
    print('CACHE: cache limpiado');
  }
}