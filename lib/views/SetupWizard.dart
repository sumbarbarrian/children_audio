import 'package:children_audio/widgets/DriveList.dart';
import 'package:children_audio/widgets/FolderList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/SelectList.dart';

class SetupWizard extends StatefulWidget {
  static const int DRIVE = 0;
  static const int FOLDER = 1;
  static const _order = [DRIVE, FOLDER];
  final onStep;
  final onFinish;
  final startStep;

  SetupWizard({ this.startStep, required this.onFinish , this.onStep});

  @override
  State<StatefulWidget> createState() => _SetupWizardState();
}

class _SetupWizardState extends State<SetupWizard> {

  late int _step;
  var _context;

  _SetupWizardState();

  @override
  void initState() {
    super.initState();
    _step = widget.startStep ?? 0;
  }

  _onChange(Item drive) async {
    _context = await widget.onStep(_step, drive);
    next();
  }

  @override
  Widget build(BuildContext context) {
    final step = SetupWizard._order[_step];
    switch(step) {
      case SetupWizard.DRIVE:
        return DriveList(_onChange);
      case SetupWizard.FOLDER:
        assert(_context != null, 'Context for step Folder is null');
        return FolderList(_context['folders'], _onChange);
    }
    return Container();
  }

  next() {
    _step++;
    if (_step < SetupWizard._order.length ) {
      setState(() {});
    } else {
      widget.onFinish();
    }
  }

  back() {
    _step--;
    if (_step >= 0 ) {
      setState(() {});
    }
  }


}
