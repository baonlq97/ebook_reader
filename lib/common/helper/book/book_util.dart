import 'dart:ui';

import 'package:ebook_reader/data/models/api/author/author.dart';

class BookUtil {
  static String getAuthorsAsString(List<Author> authors) {
    if (authors.isEmpty) {
      return "Unknown Author";
    } else {
      return authors.map((author) => fixAuthorName(author.name)).join(", ");
    }
  }

  /// For some weird reasons, Gutenberg gives the name of authors in
  /// reversed order, where the first name and last name are separated by a comma.
  /// Eg: "Fyodor Dostoyevsky" becomes "Dostoyevsky, Fyodor".
  /// This function fixes that and returns the name in the correct format.
  ///
  /// @param name Name of the author.
  /// @return Name of the author in correct format.
  static String fixAuthorName(String name) {
    return name.split(",").reversed.map((part) => part.trim()).join(" ");
  }

  /// Converts the list of languages into a single string.
  ///
  /// @param languages List of languages.
  /// @return String representation of the languages.
  static String getLanguagesAsString(List<String> languages) {
    return languages
        .map((langCode) => Locale(langCode).toLanguageTag())
        .join(", ");
  }

  /// Converts the list of subjects into a single string.
  ///
  /// @param subjects List of subjects.
  /// @param limit Maximum number of subjects to show.
  /// @return String representation of the subjects.
  String getSubjectsAsString(List<String> subjects, int limit) {
    final allSubjects = subjects
        .expand((subject) => subject.split("--"))
        .map((s) => s.trim())
        .toSet();
    final truncatedSubs =
        allSubjects.length > limit ? allSubjects.take(limit) : allSubjects;
    return truncatedSubs.join(", ");
  }
}
