import '../field.dart';
import 'ISelector.dart';

class IntSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is int) {
      return Field(name: key, type: FieldType.int, rawValue: value);
    }
    return null;
  }
}
