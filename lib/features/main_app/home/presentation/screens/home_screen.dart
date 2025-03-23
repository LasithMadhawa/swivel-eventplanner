import 'package:eventplanner/features/main_app/home/presentation/widgets/image_carousel.dart';
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const Text("56 O'Mally Road, ST LEONARDS, 2065, NSW", style: TextStyle(color: Colors.grey),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
