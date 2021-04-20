import 'package:children_audio/SignInProvider.dart';
import 'package:googleapis/androidmanagement/v1.dart';
import 'package:googleapis/drive/v3.dart';
import 'http/client.dart';

enum DriveType {
  GOOGLE_DRIVE,
  ONE_DRIVE,
}

extension DriveTypeExtension on DriveType{
  String get label {
    switch (this) {
      case DriveType.GOOGLE_DRIVE:
        return 'Google Drive';
      case DriveType.ONE_DRIVE:
        return 'MS One Drive';
    }
    return '';
  }
}

class DriveProvider {
  final DriveType _type;
  final SignInProvider _signInProvider;

  DriveProvider(this._type, this._signInProvider);

  ///
  /// Creates specific HttpClient based on user auth. type
  ///
  Future<HttpClient> _getClient() async {
    return this._signInProvider.signIn(this._getScopes());
  }

  ///
  /// Creates scope list depends on selected drive type
  ///
  List<String> _getScopes() {
    switch(this._type) {
      case DriveType.GOOGLE_DRIVE:
        return [DriveApi.driveScope];
      case DriveType.ONE_DRIVE:
        throw('is not implemented');
      default:
        return [];
    }
  }

  /// @Public
  /// loads list of available folders from drive
  ///
  Future<List> listFolders() async {
    switch(this._type) {
      case DriveType.GOOGLE_DRIVE:
        final driveAPI = DriveApi(await this._getClient());
        final result = await driveAPI.files.list(q: "mimeType = 'application/vnd.google-apps.folder' and 'me' in owners");
        return result.files;
      case DriveType.ONE_DRIVE:
        throw('is not implemented');
      default:
        return [];
    }
  }

  /// @Public
  /// loads list of media files from provided folder
  ///
  Future<List> listOfMedia(String folder) async {
    switch(this._type) {
      case DriveType.GOOGLE_DRIVE:
        final driveAPI = DriveApi(await this._getClient());
        final result = await driveAPI.files.list(q: "mimeType = 'application/vnd.google-apps.folder' and 'me' in owners");
        return result.files;
      case DriveType.ONE_DRIVE:
        throw('is not implemented');
      default:
        return [];
    }
  }

}
