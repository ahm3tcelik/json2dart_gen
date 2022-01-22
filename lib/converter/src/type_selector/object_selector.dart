import '../field.dart';
import 'ISelector.dart';

class ObjectSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is Map) {
      return Field(name: key, type: FieldType.object, rawValue: value);
    }
    return null;
  }
}
