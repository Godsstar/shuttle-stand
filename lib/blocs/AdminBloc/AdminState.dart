import 'package:equatable/equatable.dart';

class AdminPageState extends Equatable {
  @override
  List<Object> get props => [];

}

class DashBoardPage extends AdminPageState {
  bool Loading = false;
  DashBoardPage({required this.Loading});
}

class AddDriverPage extends AdminPageState {}

class AddShuttlePage extends AdminPageState {}