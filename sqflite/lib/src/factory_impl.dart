import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception_impl.dart' as impl;
import 'package:sqflite/src/sqflite_impl.dart' as impl;
import 'package:sqflite/src/sqflite_import.dart';

import 'dev_utils.dart'; // ignore: unused_import

/// sqflite Default factory
@visibleForTesting
SqfliteDatabaseFactory get sqfliteDatabaseFactory =>
    databaseFactory as SqfliteDatabaseFactory;

/// Default factory that uses the plugin.
SqfliteDatabaseFactory sqfliteDatabaseFactoryDefault =
    SqfliteDatabaseFactoryImpl();

/// Change the default factory. test only.
@visibleForTesting
set sqfliteDatabaseFactory(SqfliteDatabaseFactory? databaseFactory) =>
    databaseFactory = databaseFactory;

/// Factory implementation
class SqfliteDatabaseFactoryImpl with SqfliteDatabaseFactoryMixin {
  /// Only to set for extra debugging
  //static var _debugInternals = devWarning(true);
  static const _debugInternals = false;

  @override
  Future<T> wrapDatabaseException<T>(Future<T> Function() action) =>
      impl.wrapDatabaseException(action);

  @override
  Future<T> invokeMethod<T>(String method, [Object? arguments]) =>
      !_debugInternals
          ? impl.invokeMethod(method, arguments)
          : _invokeMethodWithLog(method, arguments);

  Future<T> _invokeMethodWithLog<T>(String method, [Object? arguments]) async {
    // ignore: avoid_print
    print('-> $method $arguments');
    final result = await impl.invokeMethod<T>(method, arguments);
    // ignore: avoid_print
    print('<- $result');
    return result;
  }
}
