part of 'folder_bloc.dart';

@immutable
sealed class FolderState {}

final class FolderInitial extends FolderState {}

final class LoadFolderState extends FolderState {
  final List<Folder> folders;

  LoadFolderState(this.folders);
}

final class LoadSingleFolderState extends FolderState {
  final Folder folder;
  LoadSingleFolderState(this.folder);
}

final class ErrorFolderState extends FolderState {
  final String errMsg;
  ErrorFolderState(this.errMsg);
}