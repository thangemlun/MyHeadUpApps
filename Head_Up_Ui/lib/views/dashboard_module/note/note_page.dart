import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:head_up_ui/bloc/note_bloc/note_bloc.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/environment/app_properties.dart';
import 'package:head_up_ui/services/impl/note_service_impl.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:head_up_ui/views/shared/skeleton.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class ReminderNotePage extends StatefulWidget {
  final String folderName;

  final Note? note;

  const ReminderNotePage({super.key, required this.folderName, this.note});

  @override
  State<StatefulWidget> createState() => ReminderNotePageState();
}

class ReminderNotePageState extends State<ReminderNotePage> {
  final _controller = quill.QuillController.basic();
  late bool toolBarCollapse = false;
  late String fSelector = AppProperties.DEFAULT_FONT;
  late var fSize = "Small";
  FocusNode _focusNode = FocusNode();
  late final PanelController panelController;
  Timer? _debounce;
  late final String noteId;
  var uuid = Uuid();
  final _titleFkey = GlobalKey<FormBuilderFieldState>();
  late bool ableToSave = false;
  late final String folderName;
  late final _noteService;
  late Note? note;
  bool isNoteEditing = false;
  final noteBloc = NoteBloc();

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
    _noteService = NoteServiceImpl();
    note = widget.note ?? null;
    folderName = widget.folderName;
    if (note != null) {
      noteId = note!.id;
      isNoteEditing = true;
      final json = jsonDecode(note!.contentJson);
      _controller.document = quill.Document.fromJson(json);
    } else {
      noteId = uuid.v4();
      _controller.formatText(
          0, _controller.document.length, quill.Attribute.h1);
    }
    _controller.addListener(_onTextChanged);
    print("note-id : $noteId");
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      // Lưu dữ liệu sau khi dừng gõ 1 giây
      _validateSaveNote();
      // Thêm logic lưu dữ liệu vào local storage hoặc backend tại đây
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.document.close();
    _controller.dispose();
  }

  _validateSaveNote() {
    noteBloc.add(SaveNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => noteBloc..add(InitialNoteEvent()),
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Note',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  BlocBuilder<NoteBloc, NoteState>(
                    builder: (context, state) {
                      switch (state) {
                        case NoteSaveState():
                          bool _titleValid =
                              _titleFkey.currentState?.isValid ?? false;
                          ableToSave = _titleValid &&
                              _controller.document
                                  .toPlainText()
                                  .trim()
                                  .isNotEmpty;
                        default:
                      }
                      return MaterialButton(
                          onPressed: ableToSave ? () => saveNote() : null,
                          child: Container(
                              padding: EdgeInsets.all(16),
                              child:
                                  ableToSave ? Icon(Boxicons.bx_check) : null));
                    },
                  )
                ],
              ),
              body: _blocBodyNote(state));
        },
      ),
    );
  }

  void saveNote() async {
    try {
      String json = jsonEncode(_controller.document.toDelta().toJson());
      String plainText = _controller.document.toPlainText();
      Note saveItem = new Note(
          id: noteId,
          title: _titleFkey.currentState?.value,
          contentJson: json,
          contentPlain: plainText,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      await _noteService.saveNote(saveItem, folderName);

      ToastificationUtil.toast("Save note successfully", ToastificationType.success, alignment: Alignment.center);
    } catch (e) {
      ToastificationUtil.toast(e.toString(), ToastificationType.error, alignment:  Alignment.center);
    }
  }

  _blocBodyNote(NoteState state) {
    switch (state) {
      case NoteInitial():
        return Skeleton(Stack(
          children: [
            _titleSection(),
            _editorSection(),
            _toolBarSection(),
          ],
        ));
      default:
        return Stack(
          children: [
            _titleSection(),
            _editorSection(),
            _toolBarSection(),
          ],
        );
    }
  }

  TextStyle styleButton() {
    return const TextStyle(
        color: Colors.white54, fontSize: 18, fontWeight: FontWeight.w500);
  }

  Widget _titleSection() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: FormBuilderTextField(
            name: 'title',
            key: _titleFkey,
            initialValue: note?.title,
            onChanged: (value) {
              _titleFkey.currentState?.validate();
            },
            decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter your title',
                prefixIcon: Icon(Icons.drive_file_rename_outline),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ));
  }

  Widget _editorSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      margin: EdgeInsets.only(top: 80),
      padding: EdgeInsets.all(10),
      child: quill.QuillEditor.basic(
        scrollController: ScrollController(),
        focusNode: _focusNode,
        configurations: quill.QuillEditorConfigurations(
          autoFocus: false,
          controller: _controller,
          scrollable: true,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  quill.QuillSimpleToolbarButtonOptions buttonOptions() {
    return quill.QuillSimpleToolbarButtonOptions(
      fontSize: quill.QuillToolbarFontSizeButtonOptions(
          style: styleButton(),
          initialValue: fSize,
          onSelected: (value) {
            print(value);
            setState(() {
              fSize = value;
              _controller.formatSelection(
                  quill.Attribute('size', quill.AttributeScope.inline, fSize));
            });
          }),
      fontFamily: quill.QuillToolbarFontFamilyButtonOptions(
          initialValue: fSelector,
          onSelected: (fontSelected) {
            print(fontSelected);
            setState(() {
              try {
                fSelector = fontSelected;
                quill.Attribute? attribute;
                attribute = quill.Attribute.fromKeyValue('font', fontSelected);
                _controller.formatSelection(attribute);
              } catch (e) {
                print(e);
              }
            });
          },
          style: styleButton()),
      selectHeaderStyleDropdownButton:
          quill.QuillToolbarSelectHeaderStyleDropdownButtonOptions(
        textStyle: styleButton(),
      ),
    );
  }

  Widget _toolBarSection() {
    return SlidingUpPanel(
      boxShadow: CupertinoContextMenu.kEndBoxShadow,
      maxHeight: 300,
      minHeight: 35,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      controller: panelController,
      panel: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: Colors.black),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    toolBarCollapse = !toolBarCollapse;
                    if (toolBarCollapse) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  });
                },
                child: const Align(
                  heightFactor: 5,
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.drag_handle_sharp,
                    color: Colors.white54,
                    size: 35,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: quill.QuillSimpleToolbar(
                  configurations: quill.QuillSimpleToolbarConfigurations(
                      controller: _controller, buttonOptions: buttonOptions()),
                ),
              ),
            ],
          )),
    );
  }
}
