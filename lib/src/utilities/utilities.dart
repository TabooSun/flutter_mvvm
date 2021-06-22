library flutter_mvvm.utilities;

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:quiver/strings.dart';

part 'messaging_center.dart';

/// Utility methods used by the flutter_mvvm framework.
class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;
}

/// Contains static variables for items used by flutter_mvvm.
class Constants {
  static String newBuildContext = "NewBuildContext";
}
