import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImages extends StatefulWidget {
  final List<String> images;

  const CarouselImages({super.key, required this.images});

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,

          child: PageView.builder(
            controller: controller,
            itemCount: widget.images.length,

            itemBuilder: (_, index) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,
                child: Image.network(widget.images[index], fit: BoxFit.cover),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        SmoothPageIndicator(
          controller: controller,
          count: widget.images.length,
          effect: const WormEffect(dotHeight: 8, dotWidth: 8),
        ),
      ],
    );
  }
}
