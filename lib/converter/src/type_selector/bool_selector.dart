import '../field.dart';
import 'ISelector.dart';

class BoolSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is bool) {
      return Field(name: key, type: FieldType.bool, rawValue: value);
    }
    return null;
  }
}
