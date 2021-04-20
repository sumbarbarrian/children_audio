import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SelectList.dart';

class Folder implements Item {

  final _folder;
  Folder(this._folder);

  @override
  String get label => _folder.name;
}

class FolderList extends StatelessWidget {
  final _folders;
  final _onSelect;

  FolderList(this._folders, this._onSelect);

  @override
  build(BuildContext context) {
    return SelectList<Folder>(_folders.map( Folder ),
        this._onSelect, 'Use this Folder?', (f) => 'use folder $f as source folder');
  }
}