import 'package:eventplanner/features/main_app/home/presentation/widgets/horizontal_image_list.dart';
import 'package:eventplanner/features/main_app/home/presentation/widgets/image_carousel.dart';
import 'package:eventplanner/features/main_app/home/presentation/widgets/organizers_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ImageCarousel(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event Name",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "56 O'Mally Road, ST LEONARDS, 2065, NSW",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Text(
                  "Organizers",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                const OrganizersList(),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Photos",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text("All Photos"),
                          SizedBox(width: 8.0),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const HorizontalImageList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
