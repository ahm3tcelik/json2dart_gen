import '../field.dart';
import 'ISelector.dart';

class DateSelector implements ISelector {
  @override
  Field? select(String key, dynamic value) {
    if (value is String) {
      try {
        DateTime.parse(value);
        return Field(name: key, type: FieldType.date, rawValue: value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
