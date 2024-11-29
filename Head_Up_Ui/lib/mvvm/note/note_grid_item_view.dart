import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:head_up_ui/bloc/folder_bloc/folder_bloc.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/mvvm/note/note_grid_item_view_model.dart';
import 'package:head_up_ui/views/dashboard_module/note/note_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteGridItemView extends StatelessWidget {
  final Note note;
  final String folderName;
  final FolderBloc folderBloc;
  final int MAX_CONTENT = 200;

  NoteGridItemView(
      {required this.folderName, required this.note, required this.folderBloc});

  final borderRadiusNote = const BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (_) => NoteGridItemViewModel(),
        child: Consumer<NoteGridItemViewModel>(
          builder: (context, viewModel, child) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền của khung comment
                borderRadius: borderRadiusNote, // Bo góc của khung
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Màu bóng nhẹ
                    spreadRadius: 2, // Độ lan tỏa của bóng
                    blurRadius: 8, // Độ mờ của bóng
                    offset: Offset(0, 4), // Bóng đổ phía dưới
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _contentNote(note, context, viewModel).blurred(
                    blur: viewModel.isActiveActions ? 4.8 : 0.0,
                    borderRadius: borderRadiusNote,
                    overlay: viewModel.isActiveActions
                        ? _actionButtons(context)
                        : null,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            viewModel.activeOpacity();
                          },
                          icon: Icon(Boxicons.bx_dots_vertical)),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _editBtn(BuildContext context) {
    var color = Colors.black;
    return MaterialButton(
      shape: CircleBorder(),
      onPressed: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReminderNotePage(folderName: folderName, note: note)))
            .then((value) {
          folderBloc.add(GetSingleFolderEvent(folderName));
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: color)),
        child: Icon(
          Boxicons.bx_edit,
          color: color,
        ),
      ),
    );
  }

  Widget _deleteBtn(BuildContext context) {
    var color = Colors.black;
    return MaterialButton(
      shape: CircleBorder(),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: color)),
        child: Icon(
          Boxicons.bx_trash,
          color: color,
        ),
      ),
    );
  }

  Widget _contentNote(
      Note note, BuildContext context, NoteGridItemViewModel viewModel) {
    String content = _doEllipsis(note.contentPlain, MAX_CONTENT);
    Color contentColor = Colors.black45;
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadiusNote,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TITLE NOTE
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _doEllipsis(note.title, 15),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          // CONTENT NOTE
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              content,
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              getFormatDate(note.createdAt),
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Container(
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        direction: Axis.horizontal,
        children: [_editBtn(context), _deleteBtn(context)],
      ),
    );
  }

  String getFormatDate(DateTime time) {
    return DateFormat("EEE, dd MMM yy").format(time);
  }

  String _doEllipsis(String text, int maxLength) {
    return text.length > maxLength
        ? text.substring(0, maxLength) + '...'
        : text;
  }
}
