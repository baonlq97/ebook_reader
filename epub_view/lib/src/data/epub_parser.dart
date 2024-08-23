import 'package:epub_view/src/data/epub_cfi_reader.dart';
import 'package:html/dom.dart' as dom;

import 'models/paragraph.dart';

export 'package:epubx/epubx.dart' hide Image;

List<EpubChapter> parseChapters(EpubBook epubBook) =>
    epubBook.Chapters!.fold<List<EpubChapter>>(
      [],
      (acc, next) {
        acc.add(next);
        next.SubChapters!.forEach(acc.add);
        return acc;
      },
    );

List<dom.Element> convertDocumentToElements(dom.Document document) =>
    document.getElementsByTagName('body').first.children;

List<dom.Element> _removeAllDiv(List<dom.Element> elements) {
  final List<dom.Element> result = [];

  for (final node in elements) {
    if (node.localName == 'div' && node.children.length > 1) {
      result.addAll(_removeAllDiv(node.children));
    } else {
      result.add(node);
    }
  }

  return result;
}

ParseParagraphsResult parseParagraphs(
  List<EpubChapter> chapters,
  EpubContent? content,
) {
  String? filename = '';
  final List<int> chapterIndexes = [];
  final List<Paragraph> paragraphs = chapters.fold(
    <Paragraph>[],
    (tempParagraphs, chapter) {
      List<dom.Element> elmList = [];

      if (filename != chapter.ContentFileName) {
        filename = chapter.ContentFileName;
        final document = EpubCfiReader().chapterDocument(chapter);
        if (document != null) {
          final result = convertDocumentToElements(document);
          elmList = _removeAllDiv(result);
        }
      }

      if (chapter.Anchor == null) {
        chapterIndexes.add(tempParagraphs.length);
      } else {
        final index = elmList.indexWhere(
          (elm) => elm.attributes['id'] == chapter.Anchor,
        );
        if (index == -1) {
          chapterIndexes.add(tempParagraphs.length);
        } else {
          chapterIndexes.add(tempParagraphs.length + index);
        }
      }

      tempParagraphs.addAll(
        elmList.map((element) => Paragraph(element, chapterIndexes.last)),
      );

      return tempParagraphs;
    },
  );

  return ParseParagraphsResult(paragraphs, chapterIndexes);
}

class ParseParagraphsResult {
  ParseParagraphsResult(this.flatParagraphs, this.chapterIndexes);

  final List<Paragraph> flatParagraphs;
  final List<int> chapterIndexes;
}
