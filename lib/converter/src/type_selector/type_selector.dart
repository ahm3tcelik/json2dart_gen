import '../field.dart';
import 'index.dart';

class TypeSelector {
  static select(String key, dynamic value) {
    final selectors = [
      () => IntSelector().select(key, value),
      () => NumSelector().select(key, value),
      () => DateSelector().select(key, value),
      () => StringSelector().select(key, value),
      () => ListSelector().select(key, value),
      () => ObjectSelector().select(key, value),
    ];

    return _getFieldFromSelectors(selectors);
  }

  static Field? _getFieldFromSelectors(List<Field? Function()> arr) {
    for (final selectCallback in arr) {
      final field = selectCallback.call();
      if (field != null) {
        return field;
      }
    }
  }
}
