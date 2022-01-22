import 'string_extension.dart';

enum FieldType {
  num,
  int,
  string,
  list,
  object,
  date,
}

class Field {
  final String name;
  final FieldType type;
  final dynamic rawValue;

  const Field({required this.name, required this.type, required this.rawValue});

  String typeName({bool enableNullSafety = true}) {
    String value = '';
    switch (type) {
      case FieldType.list:
        value = 'List<${genericName.capitalize}>';
        break;
      case FieldType.int:
        value = 'int';
        break;
      case FieldType.num:
        value = 'num';
        break;
      case FieldType.date:
        value = 'DateTime';
        break;
      case FieldType.string:
        value = 'String';
        break;
      case FieldType.object:
        value = name.capitalize;
        break;
    }
    return enableNullSafety ? '$value?' : value;
  }

  /// Example
  /// [userList] -> [user]
  String get genericName {
    return name.split('List')[0];
  }

  String get fromJsonArgumentItemName {
    switch (type) {
      case FieldType.list:
        return "List.from(json['$name'] ?? []).map((e) => ${genericName.capitalize}.fromJson(e)).toList()";
      case FieldType.date:
        return "DateTime.parse(json['$name'])";
      case FieldType.object:
        return "${name.capitalize}.fromJson(json['$name'])";
      default:
        return "json['$name']";
    }
  }

  String get toJsonItemSource {
    switch (type) {
      case FieldType.list:
        return '$name?.map((e) => e.toJson()).toList()';
      case FieldType.date:
        return '$name?.toString()';
      case FieldType.object:
        return "$name?.toJson()";
      default:
        return name;
    }
  }

  @override
  String toString() {
    return {'name': name, 'type': type, 'rawValue': rawValue}.toString();
  }
}
