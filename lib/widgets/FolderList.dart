import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googleapis/drive/v3.dart';
import 'SelectList.dart';

class FolderItem extends Item {

  final folder;
  FolderItem(this.folder) : super(folder.name);

}

class FolderList extends StatelessWidget {
  final List<File> _folders;
  final _onSelect;

  FolderList(this._folders, this._onSelect);

  @override
  build(BuildContext context) {
    final folders = _folders.map( (f) => FolderItem(f) ).toList();
    return SelectList<FolderItem>(folders ,
        this._onSelect, 'Use this Folder?', (f) => 'use folder ${f.label} as source folder');
  }
}