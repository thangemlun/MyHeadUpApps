import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:head_up_ui/bloc/folder_bloc/folder_bloc.dart';
import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/mvvm/note/note_grid_item_view.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:head_up_ui/views/dashboard_module/note/note_page.dart';
import 'package:head_up_ui/views/shared/skeleton.dart';
import 'package:toastification/toastification.dart';

class FolderPage extends StatefulWidget {
  final String folderName;

  const FolderPage(this.folderName);

  @override
  State<StatefulWidget> createState() => FolderPageState();
}

class FolderPageState extends State<FolderPage> {
  final folderBloc = FolderBloc();
  late final String folderName;
  var _searchKey = GlobalKey<FormBuilderFieldState>();
  late var notes = [];

  @override
  void initState() {
    // TODO: implement initState
    folderName = widget.folderName;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(color: Color(0xfff8f8fa)),
      child: BlocProvider<FolderBloc>(
        create: (context) => folderBloc..add(GetSingleFolderEvent(folderName)),
        child: Scaffold(
          appBar: AppBar(
            titleTextStyle: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReminderNotePage(folderName: folderName)))
                        .then((value) {
                      folderBloc.add(GetSingleFolderEvent(folderName));
                    });
                  },
                  icon: Icon(Boxicons.bx_comment_add))
            ],
            title: BlocBuilder<FolderBloc, FolderState>(
              builder: (context, state) {
                switch (state) {
                  case FolderInitial():
                    return Skeleton(_toolTipWidget(Folder.skeletonData));
                  case LoadSingleFolderState():
                    var folder = state.folder;
                    this.notes = folder.notes;
                    return _toolTipWidget(folder);
                  case ErrorFolderState():
                    String errMsg = state.errMsg;
                    ToastificationUtil.toast(errMsg, ToastificationType.error);
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      Navigator.pop(context);
                    });
                  default:
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      Navigator.pop(context);
                    });
                }
                return CircularProgressIndicator(
                  color: Colors.black12,
                );
              },
            ),
            centerTitle: true,
            primary: true,
            toolbarTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: FormBuilderTextField(
                  name: "search",
                  key: _searchKey,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Search notes ...",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black26),
                      prefixIcon: const Icon(Boxicons.bx_search_alt_2)),
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: blocNoteList(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _toolTipWidget(Folder folder) {
    return Tooltip(
      message: folder.folderName,
      child: Text(
        folder.folderName,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }

  blocNoteList() {
    return BlocBuilder<FolderBloc, FolderState>(builder: (context, state) {
      switch (state) {
        case FolderInitial():
          return Skeleton(_noteList(Note.listNoteSkeleton));
        case LoadSingleFolderState():
          return _noteList(state.folder.notes);
        default:
          return Skeleton(_noteList(Note.listNoteSkeleton));
      }
    });
  }

  _noteList(List<Note> notes) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Note note = notes[index];
          return NoteGridItemView(
            folderName: folderName,
            note: note,
            folderBloc: folderBloc,
          );
        },
      ),
    );
  }
}
