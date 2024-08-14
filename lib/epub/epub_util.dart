import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:xml/xml.dart' as xml;
import 'package:intl/intl.dart';

class EpubUtil {
  /// Parses XML text and returns an [xml.XmlDocument] or null.
  static xml.XmlDocument? parseXMLText(String text) {
    try {
      return xml.XmlDocument.parse(text);
    } catch (_) {
      return null;
    }
  }

  /// Parses an XML file from [inputStream] and returns an [xml.XmlDocument] or null.
  static Future<xml.XmlDocument?> parseXMLFile(Stream<List<int>> inputStream) async {
    try {
      final bytes = await _streamToBytes(inputStream);
      return xml.XmlDocument.parse(Utf8Decoder().convert(bytes));
    } catch (_) {
      return null;
    }
  }

  /// Parses an XML file from [byteArray] and returns an [xml.XmlDocument] or null.
  static xml.XmlDocument? parseXMLFileFromBytes(Uint8List byteArray) {
    try {
      return xml.XmlDocument.parse(Utf8Decoder().convert(byteArray));
    } catch (_) {
      return null;
    }
  }

  /// Decodes a URL-encoded string.
  static String decodeURL(String url) {
    return Uri.decodeComponent(url);
  }

  /// Converts a string to a file name format by replacing "/" with "_".
  static String asFileName(String path) {
    return path.replaceAll("/", "_");
  }

  /// Converts a relative href path to an absolute path based on [hrefRootPath].
  static String hrefAbsolutePath(String href, Directory hrefRootPath) {
    final file = File('${hrefRootPath.path}/$href').absolute;
    return file.path.replaceAll(RegExp(r'^/'), '');
  }

  /// Returns a list of entries from a [ZipFile].
  static List<ArchiveFile> zipEntries(Archive archive) {
    return archive.files;
  }

  /// Selects the first tag from an [xml.XmlDocument] by tag name.
  static xml.XmlElement? selectFirstTag(xml.XmlDocument document, String tag) {
    return document.findElements(tag).firstOrNull;
  }

  /// Selects the first child tag from an [xml.XmlElement] by tag name.
  static xml.XmlElement? selectFirstChildTag(xml.XmlElement element, String tag) {
    return element.findElements(tag).firstOrNull;
  }

  /// Selects all child tags from an [xml.XmlElement] by tag name.
  static List<xml.XmlElement> selectChildTags(xml.XmlElement element, String tag) {
    return element.findElements(tag).toList();
  }

  /// Gets the attribute value of an [xml.XmlElement] by attribute name.
  static String? getAttributeValue(xml.XmlElement element, String attribute) {
    return element.getAttribute(attribute);
  }

  /// Extension to get the first or null item from a list-like structure.
  static T? firstOrNull<T>(Iterable<T> iterable) {
    return iterable.isEmpty ? null : iterable.first;
  }

  /// Helper function to convert [Stream<List<int>] to [Uint8List].
  static Future<Uint8List> _streamToBytes(Stream<List<int>> stream) {
    return stream.toList().then((list) => Uint8List.fromList(list.expand((x) => x).toList()));
  }
}

extension ArchiveFileExt on ArchiveFile {
  String get path => this.name;
}

extension XmlElementExt on Iterable<xml.XmlElement> {
  xml.XmlElement? get firstOrNull {
    return isEmpty ? null : first;
  }
}