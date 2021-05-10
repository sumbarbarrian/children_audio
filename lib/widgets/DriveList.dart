import 'package:children_audio/DriveProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SelectList.dart';

class DriveItem extends Item {
  DriveType type;

  DriveItem(this.type) : super(type.label);
}

class DriveList extends StatelessWidget {
  final _onSelect;

  DriveList(this._onSelect);

  @override
  build(BuildContext context) {
    return SelectList<Item>(DriveType.values.map((e) => DriveItem(e)).toList(),
        this._onSelect, 'Use this Drive?', (f) => 'Use ${f.label} as main Drive');
  }
}