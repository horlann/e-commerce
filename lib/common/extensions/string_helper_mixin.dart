mixin StringHelperMixin {
  //TODO: move to string extension
  bool equalsIgnoreCase(String s1, String s2) => s1.toLowerCase() == s2.toLowerCase();

  String capitalize(String s) {
    if (s.isNotEmpty) {
      return s[0].toUpperCase() + s.substring(1);
    } else {
      return '';
    }
  }
}
