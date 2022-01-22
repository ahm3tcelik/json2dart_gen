import '../field.dart';
import 'ISelector.dart';

class StringSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is String) {
      return Field(name: key, type: FieldType.string, rawValue: value);
    }
    return null;
  }
}
