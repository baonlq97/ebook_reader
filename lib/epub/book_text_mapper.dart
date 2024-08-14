import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

class ImgEntry {
  final String path;
  final double yrel;

  ImgEntry({
    required this.path,
    required this.yrel,
  });

  /// Parses an XML string to create an [ImgEntry].
  static ImgEntry? fromXMLString(String text) {
    return fromXMLStringV1(text) ?? fromXMLStringV0(text);
  }

  /// Parses using the v1 format.
  static ImgEntry? fromXMLStringV1(String text) {
    final document = xml.XmlDocument.parse(text);
    final imgElement = document.findElements('img').firstOrNull;
    if (imgElement != null) {
      final path = imgElement.getAttribute('src');
      final yrel = imgElement.getAttribute('yrel') != null
          ? double.parse(imgElement.getAttribute('yrel')!)
          : null;
      if (path != null && yrel != null) {
        return ImgEntry(path: path, yrel: yrel);
      }
    }
    return null;
  }

  /// Parses using the v0 format.
  static ImgEntry? fromXMLStringV0(String text) {
    final xmlFormV0 = RegExp(r'^\W*<img .*>.+</img>\W*$');
    if (!xmlFormV0.hasMatch(text)) {
      return null;
    }
    final document = xml.XmlDocument.parse(text);
    final imgElement = document.findAllElements('img').firstOrNull;
    if (imgElement != null) {
      final path = imgElement.text;
      final yrel = imgElement.getAttribute('yrel') != null
          ? double.parse(imgElement.getAttribute('yrel')!)
          : null;
      if (path.isNotEmpty && yrel != null) {
        return ImgEntry(path: path, yrel: yrel);
      }
    }
    return null;
  }

  /// Converts the [ImgEntry] to an XML string.
  String toXMLString() {
    return toXMLStringV1();
  }

  /// Converts using the v1 format.
  String toXMLStringV1() {
    final formatter = NumberFormat('###.##', 'en_US');
    return '<img src="$path" yrel="${formatter.format(yrel)}">';
  }

  // You can uncomment this if you need v0 format
  /*
  String toXMLStringV0() {
    final formatter = NumberFormat('###.##', 'en_US');
    return '<img yrel="${formatter.format(yrel)}">$path</img>';
  }
  */
}

extension XmlElementExt on Iterable<xml.XmlElement> {
  xml.XmlElement? get firstOrNull {
    return isEmpty ? null : first;
  }
}
