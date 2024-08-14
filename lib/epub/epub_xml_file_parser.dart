// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:ebook_reader/epub/book_text_mapper.dart';
// import 'package:ebook_reader/epub/models/output.dart';
// import 'package:xml/xml.dart' as xml;
// import 'package:archive/archive.dart';

// class EpubXMLFileParser {
//   final String fileAbsolutePath;
//   final Uint8List data;
//   final Map<String, EpubFile> zipFile;
//   final String? fragmentId;
//   final String? nextFragmentId;

//   EpubXMLFileParser({
//     required this.fileAbsolutePath,
//     required this.data,
//     required this.zipFile,
//     this.fragmentId,
//     this.nextFragmentId,
//   });

//   // The parent folder of the XML file.
//   late final Directory fileParentFolder = Directory(fileAbsolutePath).parent;

//   /// Parses the input data as an XML document and returns the title and body content.
//   Output parseAsDocument() {
//     final document = xml.XmlDocument.parse(Utf8Decoder().convert(data));

//     String title;
//     String bodyContent;
//     xml.XmlElement? bodyElement;

//     if (fragmentId != null) {
//       // Check if the fragment ID represents a <div> tag
//       bodyElement = document.findElements('*').firstWhere(
//         (e) => e.getAttribute('id') == fragmentId,
//         orElse: () => null,
//       ) as xml.XmlElement?;

//       if (bodyElement != null) {
//         // If the fragment ID represents a <div> tag, fetch the entire body content
//         print('Fragment ID: $fragmentId represents a <div> tag. Using the fragment ID.');
//         title = document.findElements('h1').isNotEmpty ? document.findElements('h1').first.text : '';
//         bodyElement.findElements('h1').forEach((e) => e.remove());
//         bodyContent = _getNodeStructuredText(bodyElement);
//       } else {
//         print('Fragment ID: $fragmentId doesn\'t represent a <div> tag. Using the fragment and next fragment logic.');
//         final fragmentElement = document.getElementById(fragmentId);
//         title = fragmentElement?.findElements('h1').first.text ?? '';
//         final bodyBuilder = StringBuffer();
//         var currentNode = fragmentElement?.nextElementSibling;
//         final nextFragmentIdElement = nextFragmentId != null ? document.getElementById(nextFragmentId) : null;
//         fragmentElement?.findElements('h1').forEach((e) => e.remove());

//         while (currentNode != null && currentNode != nextFragmentIdElement) {
//           bodyBuilder.write(_getNodeStructuredText(currentNode, true) + '\n\n');
//           currentNode = currentNode.nextElementSibling;
//         }
//         bodyContent = bodyBuilder.toString();
//       }
//     } else {
//       // If no fragment ID is provided, fetch the entire body content
//       print('No fragment ID provided. Fetching the entire body content.');
//       bodyElement = document.rootElement;
//       title = document.findElements('h1').isNotEmpty ? document.findElements('h1').first.text : '';
//       document.findElements('h1').forEach((e) => e.remove());
//       bodyContent = _getNodeStructuredText(bodyElement);
//     }

//     return Output(
//       title: title,
//       body: bodyContent,
//     );
//   }

//   /// Parses the input data as an image and returns the image path and aspect ratio.
//   String parseAsImage(String absolutePathImage) {
//     final bytes = zipFile[absolutePathImage]?.data;
//     final image = bytes != null ? decodeImage(bytes) : null;

//     final text = ImgEntry(
//       path: absolutePathImage,
//       yrel: image != null ? image.height / image.width : 1.45,
//     ).toXMLString();

//     return '\n\n$text\n\n';
//   }

//   // Helper methods to convert the XML document to structured text

//   String _getPTraverse(xml.XmlNode node) {
//     StringBuffer buffer = StringBuffer();
//     for (var child in node.children) {
//       if (child.nodeType == xml.XmlNodeType.ELEMENT) {
//         final element = child as xml.XmlElement;
//         switch (element.name.toString()) {
//           case 'br':
//             buffer.write('\n');
//             break;
//           case 'img':
//           case 'image':
//             buffer.write(_declareImgEntry(element));
//             break;
//           default:
//             buffer.write(_getNodeStructuredText(element));
//             break;
//         }
//       } else if (child.nodeType == xml.XmlNodeType.TEXT) {
//         buffer.write((child as xml.XmlText).text.trim());
//       }
//     }
//     final paragraph = buffer.toString().trim();
//     return paragraph.isNotEmpty ? '$paragraph\n\n' : '';
//   }

//   String _getNodeTextTraverse(xml.XmlNode node) {
//     StringBuffer buffer = StringBuffer();
//     for (var child in node.children) {
//       if (child.nodeType == xml.XmlNodeType.ELEMENT) {
//         final element = child as xml.XmlElement;
//         switch (element.name.toString()) {
//           case 'p':
//             buffer.write(_getPTraverse(element));
//             break;
//           case 'br':
//             buffer.write('\n');
//             break;
//           case 'hr':
//             buffer.write('\n\n');
//             break;
//           case 'img':
//           case 'image':
//             buffer.write(_declareImgEntry(element));
//             break;
//           default:
//             buffer.write(_getNodeTextTraverse(element));
//             break;
//         }
//       } else if (child.nodeType == xml.XmlNodeType.TEXT) {
//         final text = (child as xml.XmlText).text.trim();
//         if (text.isNotEmpty) {
//           buffer.write('$text\n\n');
//         }
//       }
//     }
//     return buffer.toString();
//   }

//   String _getNodeStructuredText(xml.XmlNode node, [bool singleNode = false]) {
//     final nodeActions = {
//       'p': (xml.XmlNode n) => _getPTraverse(n),
//       'br': (xml.XmlNode n) => '\n',
//       'hr': (xml.XmlNode n) => '\n\n',
//       'img': (xml.XmlNode n) => _declareImgEntry(n as xml.XmlElement),
//       'image': (xml.XmlNode n) => _declareImgEntry(n as xml.XmlElement),
//     };

//     final action = (xml.XmlNode n) => _getNodeTextTraverse(n);

//     final children = singleNode ? [node] : node.children;
//     return children.map((child) {
//       if (child.nodeType == xml.XmlNodeType.ELEMENT) {
//         final element = child as xml.XmlElement;
//         return nodeActions[element.name.toString()]?.call(child) ?? action(child);
//       } else {
//         return action(child);
//       }
//     }).join();
//   }

//   String _declareImgEntry(xml.XmlElement node) {
//     final src = node.getAttribute('src') ?? node.getAttribute('xlink:href') ?? '';
//     final absolutePathImage = File(fileParentFolder.path, Uri.decodeFull(src))
//         .absolute
//         .path
//         .replaceFirst('/', '');
//     return parseAsImage(absolutePathImage);
//   }
// }