import 'package:eventplanner/features/main_app/home/data/repositories/organizers_repository.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/organizers/organizers_bloc.dart';
import 'package:eventplanner/features/main_app/home/presentation/widgets/organizer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizersList extends StatelessWidget {
  const OrganizersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              OrganizersBloc(context.read<OrganizersRepository>())
                ..add(FetchOrganizers()),
      child: BlocBuilder<OrganizersBloc, OrganizersState>(
        builder: (context, state) {
          if (state is OrganizersLoaded) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    OrganizerListItem(organizer: state.organizers[index]),
                    if (index != state.organizers.length - 1) const Divider()
                  ],
                );
              },
              itemCount: state.organizers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
            );
          }
          return Container();
        },
      ),
    );
  }
}