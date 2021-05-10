import 'package:flutter/material.dart';
import 'package:children_audio/DriveProvider.dart';
import 'package:children_audio/views/SetupWizard.dart';
import 'package:children_audio/widgets/DriveList.dart';
import 'package:children_audio/widgets/FolderList.dart';
import '../global.dart';
import '../DriveProvider.dart';

class SetupView extends StatefulWidget {
  SetupView();
  @override
  State<StatefulWidget> createState() => SetupViewState();
}

class SetupViewState extends State<SetupView> {
  String? _title;
  int? _step;
  var list;
  static final Global global = new Global();
  bool inited = false;

  initState() {
    global.after.then( (global) {
      if (_step == null) {
        if (global.folder == null) {
          _step = SetupWizard.FOLDER;
        }
        if (global.driveType == null) {
          _step = SetupWizard.DRIVE;
        }
      }
      inited = true;
      setState((){});
    });
  }

  ///
  /// Handles the setup steps.
  ///
  _onStep(step, value) async {
    final settings = await global.after;
    switch (step) {

      case SetupWizard.DRIVE:
        _title = 'Select Drive';
        global.driveType = (value as DriveItem).type.name;
        final folders = await global.provider!.listFolders();
        return { 'folders': folders };

      case SetupWizard.FOLDER:
        _title = 'Select Folder';
        global.folder = (value as FolderItem).folder.name;
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return inited ?
      Scaffold(
        appBar: AppBar(
          title: Text(_title ?? ''),
        ),
        body: Center(
            child: SetupWizard(startStep: _step, onStep: this._onStep, onFinish: () => Navigator.pushNamed(context, '/'))
        )
      ): Text('Loading');
  }
}