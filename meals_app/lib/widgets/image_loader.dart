import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;

  ImageLoader(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Image.network(imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: ( ctxt,  child,  progress) {
        if (progress == null) return child;
        return SizedBox(
          height: 10,
          width: 10,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
