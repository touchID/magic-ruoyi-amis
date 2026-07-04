import 'dart:typed_data';
import 'dart:convert';

class ImageUtil {
  static ImageUtil? _instance;

  static ImageUtil instance() {
    _instance ??= ImageUtil._();
    return _instance!;
  }

  ImageUtil._();

  Future<Uint8List?> decodeBase64ToImage(String base64Str) async {
    try {
      return base64.decode(base64Str);
    } catch (_) {
      return null;
    }
  }
}
