import 'package:children_audio/DriveProvider.dart';
import 'package:children_audio/SignInProvider.dart';
import 'package:children_audio/http/client.dart';
import 'package:children_audio/widgets/SelectList.dart';
import 'package:children_audio/widgets/SetupWizard.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:shared_preferences/shared_preferences.dart';

var driveAPI;
var settings;
DriveProvider provider;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio for Children',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Audio for Children'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var _folder;
  var _type;
  var list;

  @override
  void initState() {
    try {
      super.initState();
      SharedPreferences.getInstance().then( (_settings) async {
        settings = _settings;
        _type = _settings.get('drive-type');
        _folder = _settings.get('folder');
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List> loadItems() async {
    var _list;
    try {

      final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
      final signIn.GoogleSignInAccount account = await googleSignIn.signIn();
      final Map<String, String> _headers = await account.authHeaders;
      final _client = new HttpClient(_headers);

      driveAPI = drive.DriveApi(_client);
      final files = await driveAPI.files;

      final result = await files.list(q: "mimeType = 'application/vnd.google-apps.folder' and 'me' in owners");
      _list = result.files;
    } catch (e) {
      print(e);
    }
    return _list;
  }

  void onSelect(String folder) {
    settings.setString('folder', folder);
  }

  _onStep(step, value) async{
    switch (step) {
      case WizardStep.Drive:
        _type = value;
        provider = DriveProvider(value, SignInProvider(SignInType.GOOGLE));
        return { 'folders': provider.listFolders() };
      case WizardStep.Folder:
        _folder = value;
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _folder == null
            ? Text('folder is $_folder')
            : SetupWizard(_onStep)
      )
    );
  }
}
