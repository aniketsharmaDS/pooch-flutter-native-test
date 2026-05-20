import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';

class SafeString extends MappableField {
  const SafeString() : super(hook: const SafeStringHook());
}

class SafeInt extends MappableField {
  const SafeInt() : super(hook: const SafeIntHook());
}

class SafeDouble extends MappableField {
  const SafeDouble() : super(hook: const SafeDoubleHook());
}

class SafeBool extends MappableField {
  const SafeBool() : super(hook: const SafeBoolHook());
}

class SafeDateTime extends MappableField {
  const SafeDateTime() : super(hook: const SafeDateTimeHook());
}

class SafeListHook extends MappingHook {
  const SafeListHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) return value;
    return [];
  }
}

class SafeList extends MappableField {
  const SafeList() : super(hook: const SafeListHook());
}
// class SafeListHook extends MappingHook {
//   const SafeListHook();

//   @override
//   Object? beforeDecode(Object? value) {
//     if (value is List) return value;
//     return [];
//   }
// }
