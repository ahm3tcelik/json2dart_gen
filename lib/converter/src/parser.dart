import 'dart:convert';

import 'field.dart';
import 'type_selector/type_selector.dart';

class JsonParser {
  static List<Field> parse(String jsonString) {
    try {
      final result = json.decode(jsonString);
      return recursiveGetFields(result);
    } catch (_) {
      rethrow;
    }
  }

  static List<Field> recursiveGetFields(dynamic result) {
    final fieldList = <Field>[];
    if (result is Map) {
      for (var dynamicField in result.entries) {
        final field = TypeSelector.select(dynamicField.key, dynamicField.value);
        if (field != null) {
          fieldList.add(field);
        }
      }
    } else if (result is List) {
      if (result.isNotEmpty) {
        fieldList.addAll(recursiveGetFields(result[0]));
      }
    }
    return fieldList;
  }
}
