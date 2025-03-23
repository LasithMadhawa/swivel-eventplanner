import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/images/images_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;
  final int _totalPages = 10;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagesBloc, ImagesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ImagesLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(color: Colors.red),
            ),
          );
        } else if (state is ImagesFailure) {
          return Center(child: Text(state.message));
        } else if (state is ImagesLoaded) {
          return Stack(
            children: [
              CarouselSlider(
                carouselController: CarouselSliderController(),
                options: CarouselOptions(
                  initialPage: _currentIndex,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items:
                    state.images.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(image.url!, fit: BoxFit.cover),
                          );
                        },
                      );
                    }).toList(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  margin: const EdgeInsets.all(8.0),
                  child: Text("${_currentIndex+1}/$_totalPages", style: const TextStyle(fontWeight: FontWeight.w500),),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
