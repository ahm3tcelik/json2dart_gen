import '../field.dart';
import 'ISelector.dart';

class NumSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is num) {
      return Field(name: key, type: FieldType.num, rawValue: value);
    }
    return null;
  }
}
