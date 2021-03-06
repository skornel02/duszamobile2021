extension StringHufinator on String {
  String get huf => this + " HUF";
}

extension DoubleHufinator on double {
  String get huf => toString() + " HUF";
}

extension IntHufinator on int {
  String get huf => toString() + " HUF";
}