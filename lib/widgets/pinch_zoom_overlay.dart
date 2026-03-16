import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PinchZoomOverlay extends StatelessWidget {
  final String imageUrl;

  const PinchZoomOverlay({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,

      insetPadding: EdgeInsets.zero,

      child: GestureDetector(
        onTap: () => Navigator.pop(context),

        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,

          child: Center(
            child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
