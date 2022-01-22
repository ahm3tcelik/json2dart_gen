import '../field.dart';
import 'ISelector.dart';

class ListSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is List) {
      return Field(name: key, type: FieldType.list, rawValue: value);
    }
    return null;
  }
}
