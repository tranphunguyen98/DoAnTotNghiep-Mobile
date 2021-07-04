import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class UrlImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  const UrlImage({Key key, this.url, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? 48,
      width: width ?? 48,
      fit: BoxFit.cover,
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(
        strokeWidth: 1,
      ),
      cacheManager: CacheManager(
        Config(
          'customCacheKey',
          stalePeriod: const Duration(days: 30),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
