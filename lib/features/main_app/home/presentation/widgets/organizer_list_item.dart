import '../../../../../core/models/organizer_model.dart';
import 'package:flutter/material.dart';

class OrganizerListItem extends StatelessWidget {
  final OrganizerModel organizer;
  const OrganizerListItem({super.key, required this.organizer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const CircleAvatar(radius: 20),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(organizer.name ?? ""),
                    Text(organizer.email ?? ""),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
