import 'package:children_audio/widgets/DriveList.dart';
import 'package:children_audio/widgets/FolderList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'SelectList.dart';

class SetupWizard extends StatefulWidget {
  final _onStep;
  SetupWizard(this._onStep);

  @override
  State<StatefulWidget> createState() => _SetupWizardState();
}

enum WizardStep { Drive , Folder }

class _SetupWizardState extends State<SetupWizard> {
  final _order = [WizardStep.Drive, WizardStep.Folder];
  WizardStep _step;
  var _context;

  _SetupWizardState();

  @override
  void initState() {
    super.initState();
    _step = _order.removeAt(0);
  }

  _onChange(Item drive) async {
    _context = await widget._onStep(_step, drive);
    assert(_context == null);
    next();
  }

  @override
  Widget build(BuildContext context) {
    switch(_step) {
      case WizardStep.Drive:
        return DriveList(_onChange);
      case WizardStep.Folder:
        return FolderList(_context['drives'], _onChange);
    }
    return null;
  }

  next() {
    setState(() {
      _step: _order.removeAt(0);
    });
  }


}
