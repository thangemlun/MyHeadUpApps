import 'package:bloc/bloc.dart';
import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/repository/folder_data_store.dart';
import 'package:head_up_ui/data/repository/impl/folder_data_store_impl.dart';
import 'package:meta/meta.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {

  late List<Folder> blocFolders = [];

  final FolderDataStore folderStorage = FolderDataStoreImpl();

  FolderBloc() : super(FolderInitial()) {
    on<FolderEvent>((event, emit) async {
      // TODO: implement event handler
      switch(event) {
        case GetFolderEvent():
          // TODO: Handle this case.
          await triggerGetFolderEvent(event, emit);
        case SaveFolderEvent():
          // TODO: Handle this case.
          await triggerSaveFolderEvent(event, emit);
        case FilterFolderEvent():
          // TODO: Handle this case.
          await triggerFilterFolderEvent(event, emit);
        case GetSingleFolderEvent():
          await triggerGetSingleFolderEvent(event, emit);
        default:
          emit(FolderInitial());
      }
    });
  }

  Future triggerGetFolderEvent(GetFolderEvent event, Emitter emit) async {
    await Future.delayed(Duration(microseconds: 500));
    List<Folder> folders = await folderStorage.getAllFolders();
    blocFolders = folders;
    emit(LoadFolderState(blocFolders));
  }

  Future triggerSaveFolderEvent(SaveFolderEvent event, Emitter emit) async {
    emit(FolderInitial());
    await Future.delayed(Duration(microseconds: 500));
  }

  Future triggerFilterFolderEvent(FilterFolderEvent event, Emitter emit) async {
    emit(FolderInitial());
    List<Folder> folders = await folderStorage.getAllFolders();
    blocFolders = folders;
    if (event.filterBy == "name") {
      blocFolders.sort((a, b) => b.folderName.compareTo(a.folderName));
    } else if (event.filterBy == "createdTime") {
      blocFolders.sort((a,b) => a.createdTime.compareTo(b.createdTime));
    }
    await Future.delayed(Duration(microseconds: 500));
    emit(LoadFolderState(blocFolders));
  }

  Future triggerGetSingleFolderEvent(GetSingleFolderEvent event, Emitter emit) async {
    try {
      emit(FolderInitial());
      String folderName = event.folderName;
      Folder? folder = await folderStorage.getFolder(folderName);
      if (folder == null) {
        emit(ErrorFolderState(getErrMessage("Folder not found")));
      } else {
        await Future.delayed(Duration(microseconds: 500));
        emit(LoadSingleFolderState(folder));
      }
    } catch (e) {
      emit(ErrorFolderState("Internal error"));
    }
  }

  String getErrMessage(String err) {
    return "Error while getting folder : ${err}";
  }

}
