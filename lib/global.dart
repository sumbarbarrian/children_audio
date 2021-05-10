import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'DriveProvider.dart';
import 'SignInProvider.dart';


class Global {

  static SharedPreferences? _settings;
  static Global? _instance;

  String? folder;

  DriveType? _type;
  DriveProvider? _provider;

  late final Future<Global> after;

  factory Global() => Global._instance ??= Global._createGlobal();

  DriveProvider? get provider => _provider;

  DriveType? get driveType => _type;

  bool get isReady => this.folder != null && this._type != null;

  set driveType(dynamic type) {
    assert(type is DriveType || DriveTypeExtension.values().contains(type), 'type value ${type} is invalid. Type can be DriveType or ${DriveTypeExtension.values()}');
    _type = DriveTypeExtension.from(type) ?? null;
    if (_type != null) {
      _provider = DriveProvider(_type!, SignInProvider(SignInType.GOOGLE));
    } else {
      throw 'Unknown drive type "$type"';
    }
  }

  Global._createGlobal() {
    after = SharedPreferences.getInstance()
      .then( (SharedPreferences settings) {
        Global._settings = settings;
        String? _driveType = settings.getString('drive-type');

        if (_driveType != null) {
          driveType = _driveType;
        }

        folder = _type != null ? settings.getString('folder') : null;
      })
      .then<Global>((_) => Future.value(Global._instance));
  }

  clear() => _settings?.clear();
}



