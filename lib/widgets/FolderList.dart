import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googleapis/drive/v3.dart';
import 'SelectList.dart';

class Folder extends Item {

  final _folder;
  Folder(this._folder) : super(_folder.name);

  String get folder => _folder;
}

class FolderList extends StatelessWidget {
  final List<File> _folders;
  final _onSelect;

  FolderList(this._folders, this._onSelect);

  @override
  build(BuildContext context) {
    final folders = _folders.map( (f) => Folder(f) ).toList();
    return SelectList<Folder>(folders ,
        this._onSelect, 'Use this Folder?', (f) => 'use folder ${f.label} as source folder');
  }
}