import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef String QuestionType<T>(T selected);
typedef void OnSelect<T>(T selected);

class Item {
  String _label;

  Item(this._label);

  String get label => _label;
}

class SelectList<T extends Item> extends StatelessWidget {
  final List<T> _list;
  final OnSelect<T> _onSelect;
  final String _title;
  final QuestionType<T> _question;

  SelectList(this._list, this._onSelect, this._title, this._question);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context,index) {
        final item = _list[index];
        final name = item.label;
        return ListTile(
          title: Text(name),
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(this._title),
                  content: Text(this._question(item)),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        this._onSelect(item);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
            );
          },
        );
      }
      , itemCount: this._list.length);
  }
}
