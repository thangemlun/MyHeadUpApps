import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:head_up_ui/bloc/folder_bloc/folder_bloc.dart';
import 'package:head_up_ui/bloc/user_info_bloc.dart';
import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/services/impl/folder_service_impl.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:head_up_ui/views/dashboard_module/folder/folder_page.dart';
import 'package:head_up_ui/views/shared/skeleton.dart';
import 'package:head_up_ui/widgets/pop_up_filter_menu.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final UserInfoBloc userInfoBloc = UserInfoBloc();
  bool isDarkMode = false;
  late String selectedFolder;
  late bool toolBarCollapse = false;
  final _folderNameKey = GlobalKey<FormBuilderFieldState>();
  final folderBloc = FolderBloc();
  final folderService = FolderServiceImpl();
  late List<Folder> folders = [];
  late String filterBy = "createdTime";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DashboardPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    folderBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xfff8f8fa)),
      child: BlocProvider(
        create: (context) => folderBloc..add(FilterFolderEvent(filterBy)),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                'My folders',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              actions: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  height: 300,
                  child: Stack(
                    children: [
                      BlocBuilder<FolderBloc, FolderState>(
                        builder: (context, state) {
                          return PopUpFilterMenu(
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(Icons.abc),
                                    title: Text("Name"),
                                  ),
                                  value: "name",
                                ),
                                const PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(CupertinoIcons.clock),
                                    title: Text("Created time"),
                                  ),
                                  value: "createdTime",
                                ),
                              ];
                            },
                            onSelect: folders.isNotEmpty && folders.length > 1
                                ? (value) {
                                    filterBy = value;
                                    folderBloc.add(FilterFolderEvent(value));
                                  }
                                : null,
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                          'Sort by', // Số lượng dữ liệu
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            floatingActionButton: SpeedDial(
              // Mặc định là false, nhưng có thể thay đổi cách mở rộng
              animatedIcon: AnimatedIcons.menu_home,
              backgroundColor: Colors.black,
              renderOverlay: false,
              foregroundColor: Colors.white,
              children: [
                SpeedDialChild(
                    shape: const CircleBorder(),
                    child: const Icon(
                      Boxicons.bx_folder_plus,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return _addFolderSection();
                          });
                    }),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  blocFolderList()
                  // Content Dashboard
                ],
              ),
            )),
      ),
    );
  }

  Widget getBackground() {
    return isDarkMode
        ? _getLottie('assets/images/weathers/night-animation.json')
        : _getLottie('assets/images/weathers/morning-animation.json');
  }

  Widget _getLottie(String path) {
    return Lottie.asset(path, fit: BoxFit.fill);
  }

  Widget _addFolderSection() {
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        height: 200,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Add folder",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  bool validName =
                      _folderNameKey.currentState?.isValid ?? false;
                  if (validName) {
                    // Add folder
                    String value = _folderNameKey.currentState?.value.trim();
                    Folder folder = Folder(
                        folderName: value,
                        notes: [],
                        createdTime: DateTime.now(),
                        updatedTime: DateTime.now());

                    folderService
                        .checkExistedFolder(folder)
                        .then((valid) async {
                      if (valid) {
                        await folderService.saveFolder(folder);
                        ToastificationUtil.toast("Add folder successfully", ToastificationType.success);
                        folderBloc.add(FilterFolderEvent(filterBy));
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    });
                  } else {
                    ToastificationUtil.toast("Folder name can not be empty", ToastificationType.error);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff63cdff)),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Folder Name",
                  prefixIcon: Icon(Boxicons.bx_folder)),
              name: "Folder name",
              key: _folderNameKey,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()]),
            ),
          ),
        ),
      ),
    );
  }

  Widget blocFolderList() {
    return BlocBuilder<FolderBloc, FolderState>(
        bloc: folderBloc,
        builder: (context, state) {
          if (state is FolderInitial) {
            return Skeleton(_folderList(List.of([Folder.skeletonData])));
          } else if (state is LoadFolderState) {
            this.folders = state.folders;
            return _folderList(folders);
          }
          return _folderList([]);
        });
  }

  Widget _folderList(List<Folder> items) {
    return items.length > 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 500, // Set a fixed height for the grid view
              child: AlignedGridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 10,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Folder? folder = items[index];
                  return _folder(folder);
                },
              ),
            ),
          )
        : Center(
            child: Text(
              "No folder created",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          );
  }

  Widget _folder(Folder folder) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(
                builder: (context) => FolderPage(folder.folderName)))
            .then((value) {
          folderBloc.add(FilterFolderEvent(filterBy));
        });
      },
      child: Container(
        width: 100, // Thêm chiều rộng cố định
        height: 100,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/icons/folder-icon.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
            // size folder
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  '${folder.notes.length}', // Số lượng dữ liệu
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12),
                ),
              ),
            ),
            // name folder
            Container(
              margin: const EdgeInsets.only(top: 80),
              alignment: Alignment.center,
              child: Tooltip(
                message: folder.folderName,
                child: Text(
                  '${folder.folderName}', // Số lượng dữ liệu
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
