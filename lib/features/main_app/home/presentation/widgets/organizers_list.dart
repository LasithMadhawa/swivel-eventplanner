import '../blocs/organizers/organizers_bloc.dart';
import 'organizer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizersList extends StatelessWidget {
  const OrganizersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizersBloc, OrganizersState>(
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
    );
  }
}