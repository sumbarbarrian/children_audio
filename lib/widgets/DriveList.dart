import 'package:flutter/cupertino.dart';

import 'SelectList.dart';

class DriveList extends SelectList{
  final _folders;
  final _onSelect;

  DriveList(this._folders, this._onSelect) {
    super();
  }

  @override
  build(BuildContext context) {
    return super<String>(_folders.map( (f) => f.name), this._onSelect, 'Use this Drive?', (f) => 'use $f as as main Drive');
  }
}