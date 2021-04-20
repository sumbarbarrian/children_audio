import 'package:children_audio/DriveProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SelectList.dart';

class DriveList extends StatelessWidget {
  final _onSelect;

  DriveList(this._onSelect);

  @override
  build(BuildContext context) {
    return SelectList<Item>(DriveType.values.map((e) => Item(e.label)).toList(),
        this._onSelect, 'Use this Drive?', (f) => 'use $f as as main Drive');
  }
}