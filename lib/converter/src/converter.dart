import 'package:dart_writer/dart_writer.dart';
import 'package:json2dart_gen/converter/src/string_extension.dart';

import 'field.dart';
import 'parser.dart';

class Converter {
  static String convert(String className, String rawJson) {
    try {
      final fields = _import(rawJson);
      String result = _export(className, fields);
      result = '$result${recursiveExportSubClass(fields, <String>[])}';
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  static List<Field> _import(String rawJson) {
    return JsonParser.parse(rawJson);
  }

  static String recursiveExportSubClass(
      List<Field> customClassFields, List<String> createdCustomClasses) {
    String result = '';
    for (final field in customClassFields) {
      if (field.type == FieldType.object || field.type == FieldType.list) {
        final customClassFields = JsonParser.recursiveGetFields(field.rawValue);

        if (createdCustomClasses.contains(field.name.capitalize)) {
          continue;
        } else {
          createdCustomClasses.add(field.name.capitalize);
          final thisClassResult =
              _export(field.name.capitalize, customClassFields);
          result = '$result\n$thisClassResult';
        }

        final subClassResult =
            recursiveExportSubClass(customClassFields, createdCustomClasses);
        result = '$result\n$subClassResult';
      }
    }
    return result;
  }

  static String _export(String className, List<Field> fields) {
    var code = [
      Class(className, attributes: [
        for (Field field in fields)
          Attribute(
            name: field.name,
            type: field.typeName(),
            modifiers: 'final',
          ),
      ], constructors: [
        Constructor(
          className: className,
          modifier: 'const',
          param: Parameter([
            for (Field field in fields)
              ParameterItem(
                'this.${field.name}',
                isNamed: true,
                isRequired: true,
              ),
          ]),
        ),
        Constructor(
          className: className,
          constructorName: 'fromJson',
          modifier: 'factory',
          param: Parameter([
            ParameterItem('Map<String, dynamic> json', isRequired: true),
          ]),
          statements: [
            Return(
              Call(
                className,
                argument: Argument([
                  for (Field field in fields)
                    ArgumentItem(
                      field.fromJsonArgumentItemName,
                      name: field.name,
                    ),
                ]),
              ),
            ),
          ],
        ),
      ], methods: [
        Method(
          name: 'toJson',
          returnType: 'Map<String, dynamic>',
          statements: [
            Assign('final json', '<String, dynamic>{}'),
            for (Field field in fields)
              Assign("json['${field.name}']", field.toJsonItemSource),
            Return('json'),
          ],
        )
      ]),
    ];

    var context = EditorContext(enableDartFormatter: true);
    return context.build(code);
  }
}
