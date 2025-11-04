import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AnimatedCarousel extends StatelessWidget {
  const AnimatedCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/images/card1.png',
      'assets/images/card3.png',
      'assets/images/card4.png',
      'assets/images/card2.png',
    ];

    // Card styling is now inherited from the global theme,
    // but we can add specific elevation if we want.
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (context, index, realIndex) {
          // This AnimatedSwitcher is a nice touch!
          // It fades the image when the content changes.
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: SizedBox.expand(
              key: ValueKey(images[index]),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: double.infinity, // Fill the parent (SizedBox or Expanded)
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1, // Show one full item
          // Faster, smoother animation curve
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}
