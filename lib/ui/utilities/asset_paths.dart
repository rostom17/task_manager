import 'package:http/http.dart' as http;

class AssetPaths{
  static const String _basePath = 'assets';
  static const _imagePath = '$_basePath/images';

  static const String backGroundSVG = '$_imagePath/background.svg';
  static const String logoSVG = '$_imagePath/logo.svg';
  static const String url = 'https://drive.google.com/file/d/1uFAdrk_PYFsk16Yyq2ZJkm2dN2Nz56ey/view?usp=sharing';
  static  RegExp emailChecker = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}