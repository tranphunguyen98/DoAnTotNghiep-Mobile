import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  String url;
  BoxFit fit;
  double width;
  double height;
  double aspectRatio;
  double iconHolderSize = 40;

  ShimmerImage(
    this.url, {
    this.fit,
    this.width,
    this.height,
    this.aspectRatio,
    this.iconHolderSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[100],
          child: aspectRatio != null
              ? AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    child: _buildIcon(),
                  ),
                )
              : SizedBox(
                  width: width,
                  height: height,
                  child: _buildIcon(),
                ),
        ),
        if (aspectRatio != null) AspectRatio(
                aspectRatio: aspectRatio,
                child: Image.network(
                  url,
                  fit: fit ?? BoxFit.contain,
                ),
              ) else Image.network(
                url,
                width: width,
                height: height,
                fit: fit ?? BoxFit.contain,
              ),
      ],
    );
  }

  Widget _buildIcon() {
    return Center(
      child: Icon(
        Icons.crop_original,
        color: Colors.red,
        size: iconHolderSize,
      ),
    );
  }
}
