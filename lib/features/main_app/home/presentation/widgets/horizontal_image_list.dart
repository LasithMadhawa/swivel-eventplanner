import 'package:eventplanner/features/main_app/home/presentation/blocs/images/images_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalImageList extends StatelessWidget {
  const HorizontalImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesBloc, ImagesState>(
      builder: (context, state) {
        if (state is ImagesLoaded) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:
                        state.images
                            .map(
                              (img) => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5, color: Colors.grey)
                                ),
                                width: 250,
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child:
                                          img.thumbnailUrl != null
                                              ? Image.network(img.thumbnailUrl!, fit: BoxFit.cover,)
                                              : Container(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(img.title ?? "", style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                          const SizedBox(height: 8.0,),
                                          Text("${img.title} ${img.title}", maxLines: 3, overflow: TextOverflow.ellipsis,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
