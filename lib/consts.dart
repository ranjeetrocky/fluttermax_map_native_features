import 'package:flutter/foundation.dart';

void kprint(Object objs) {
  if (kDebugMode) {
    print(objs.toString());
  }
}
