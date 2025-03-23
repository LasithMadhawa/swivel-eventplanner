part of 'organizers_bloc.dart';

sealed class OrganizersEvent extends Equatable {
  const OrganizersEvent();

  @override
  List<Object> get props => [];
}

class FetchOrganizers extends OrganizersEvent {}