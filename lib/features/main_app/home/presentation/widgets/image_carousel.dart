import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/images_repository.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/images/images_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagesBloc(context.read<ImagesRepository>())..add(FetchImages()),
      child: BlocConsumer<ImagesBloc, ImagesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ImagesLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.white,
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(color: Colors.red,),
              ),
            );
          } else if (state is ImagesFailure) {
            return Center(child: Text(state.message));
          } else if (state is ImagesLoaded) {
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16/9,
                enableInfiniteScroll: false,
                viewportFraction: 1,
              ),
              items: state.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(image.url!, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
