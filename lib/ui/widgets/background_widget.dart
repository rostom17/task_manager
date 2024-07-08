import 'package:flutter/material.dart';
import 'package:task_manager/ui/utilities/asset_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPaths.backGroundSVG,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child,

      ],
    );
  }
}
