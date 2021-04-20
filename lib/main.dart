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
  String _folder;
  String _type;
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

  void onSelect(String folder) {
    settings.setString('folder', folder);
  }

  _onStep(step, value) async {
    final label = (value as Item).label;
    switch (step) {
      case WizardStep.Drive:
        _type = label;
        settings.setString('drive-type', _type);
        provider = DriveProvider(value.type, SignInProvider(SignInType.GOOGLE));
        final folders = await provider.listFolders();
        return { 'folders': folders };
      case WizardStep.Folder:
        _folder = label;
        settings.setString('folder', _folder);
        setState(() {});
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _folder != null
            ? Text('folder is $_folder')
            : SetupWizard(_onStep)
      )
    );
  }
}
