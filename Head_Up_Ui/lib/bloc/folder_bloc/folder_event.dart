part of 'folder_bloc.dart';

@immutable
sealed class FolderEvent {}

class GetFolderEvent extends FolderEvent {}

class SaveFolderEvent extends FolderEvent {
  final Folder folder;
  SaveFolderEvent(this.folder);
}

class FilterFolderEvent extends FolderEvent {
  final String filterBy;
  FilterFolderEvent(this.filterBy);
}

class LoadFolderEvent extends FolderEvent {}

class GetSingleFolderEvent extends FolderEvent {
  final String folderName;
  GetSingleFolderEvent(this.folderName);
}
