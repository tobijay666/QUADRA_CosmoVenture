part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class Logout extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserEntity user;
  const SettingsLoaded({required this.user});
}
