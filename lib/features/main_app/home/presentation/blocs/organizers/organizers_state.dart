part of 'organizers_bloc.dart';

sealed class OrganizersState extends Equatable {
  const OrganizersState();
  
  @override
  List<Object> get props => [];
}

final class OrganizersInitial extends OrganizersState {}

final class OrganizersLoading extends OrganizersState {}

final class OrganizersFailure extends OrganizersState {
  final String message;

  const OrganizersFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class OrganizersLoaded extends OrganizersState {
  final List<OrganizerModel> organizers;
  const OrganizersLoaded(this.organizers);

  @override
  List<Object> get props => [organizers];
}
