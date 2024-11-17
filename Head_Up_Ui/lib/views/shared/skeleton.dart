import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Skeleton extends StatelessWidget{
  final Widget widget;

  const Skeleton(this.widget);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(),
      child: widget);
  }

}