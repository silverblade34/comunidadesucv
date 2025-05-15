import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarImage extends StatelessWidget {
  final String avatar;
  final String avatarError;
  final double width;
  final double height;

  const AvatarImage({
    super.key,
    required this.avatar,
    required this.avatarError,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatar,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey.withOpacity(0.2),
      ),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl: avatarError,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.2),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: Colors.grey.withOpacity(0.2),
          child: Icon(
            Icons.person,
            size: width * 0.6,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
