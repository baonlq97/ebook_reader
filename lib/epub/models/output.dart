import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:xml/xml.dart' as xml;
/// Represents the output of the XML document parsing.
  /// @property title The title of the XML document.
  /// @property body The body content of the XML document.
  class Output {
    final String? title;
    final String body;

    Output({this.title, required this.body});
  }