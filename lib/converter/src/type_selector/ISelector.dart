import '../field.dart';

abstract class ISelector {
  Field? select(String key, dynamic value);
}
